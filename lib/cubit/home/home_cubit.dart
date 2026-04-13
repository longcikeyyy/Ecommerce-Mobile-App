import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/services/remote/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final FirebaseService _firebaseService;
  final AppLogger _logger;

  HomeCubit(this._firebaseService, this._logger) : super(const HomeState());

  Future<void> loadCategories() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final categories = await _firebaseService.getCategories();
      _logger.i('Loaded ${categories.length} categories');
      emit(state.copyWith(isLoading: false, categories: categories));
    } catch (e, st) {
      _logger.e('Failed to load categories', error: e, stackTrace: st);
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load categories.',
        ),
      );
    }
  }

  Future<void> loadTopSellingProducts() async {
    emit(state.copyWith(isTopSellingLoading: true, topSellingErrorMessage: ''));

    try {
      final products = await _firebaseService.getTopSellingProducts();
      _logger.i('Loaded ${products.length} top selling products');
      emit(
        state.copyWith(
          isTopSellingLoading: false,
          topSellingProducts: products,
        ),
      );
    } catch (e, st) {
      _logger.e(
        'Failed to load top selling products',
        error: e,
        stackTrace: st,
      );
      emit(
        state.copyWith(
          isTopSellingLoading: false,
          topSellingErrorMessage: 'Failed to load top selling products.',
        ),
      );
    }
  }
}
