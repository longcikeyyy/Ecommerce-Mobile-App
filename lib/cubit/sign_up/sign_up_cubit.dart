import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/services/remote/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final FirebaseService _firebaseService;
  final AppLogger _logger;

  SignUpCubit(this._firebaseService, this._logger) : super(const SignUpState());

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: '', isSuccess: false));

    try {
      await _firebaseService.signUpWithEmail(
        firstName: firstName,
        lastName: lastName,
        email: email,
        password: password,
      );

      _logger.i('Sign up successful for $email');
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } on FirebaseAuthException catch (e) {
      _logger.e('Sign up failed', error: e);
      final message = _mapFirebaseAuthError(e.code);
      emit(state.copyWith(isLoading: false, errorMessage: message));
    } catch (e, st) {
      _logger.e('Sign up unexpected error', error: e, stackTrace: st);
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
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'operation-not-allowed':
        return 'Email/password sign up is not enabled.';
      default:
        return 'Sign up failed. Please try again.';
    }
  }
}
