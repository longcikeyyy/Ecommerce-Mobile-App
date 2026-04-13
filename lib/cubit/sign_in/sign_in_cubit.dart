import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/services/remote/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'sign_in_state.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final FirebaseService _firebaseService;
  final AppLogger _logger;

  SignInCubit(this._firebaseService, this._logger) : super(const SignInState());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: '', isSuccess: false));

    try {
      await _firebaseService.signInWithEmail(
        email: email,
        password: password,
      );

      _logger.i('Sign in successful for $email');
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseAuthException catch (e) {
      _logger.e('Sign in failed', error: e);
      final message = _mapFirebaseAuthError(e.code);
      emit(state.copyWith(isLoading: false, errorMessage: message));
    } catch (e, st) {
      _logger.e('Sign in unexpected error', error: e, stackTrace: st);
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Something went wrong. Please try again.',
        ),
      );
    }
  }

  String _mapFirebaseAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
        return 'Incorrect password.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      default:
        return 'Sign in failed. Please try again.';
    }
  }
}
