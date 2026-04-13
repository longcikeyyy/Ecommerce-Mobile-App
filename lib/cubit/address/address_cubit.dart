import 'package:ecommerce_mobile_app/core/logging/app_logger.dart';
import 'package:ecommerce_mobile_app/services/remote/firebase_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'address_state.dart';

@injectable
class AddressCubit extends Cubit<AddressState> {
  final FirebaseService _firebaseService;
  final AppLogger _logger;

  AddressCubit(this._firebaseService, this._logger)
      : super(const AddressState());

  Future<void> loadAddresses() async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    try {
      final addresses = await _firebaseService.getAddresses();
      _logger.i('Loaded ${addresses.length} addresses');
      emit(state.copyWith(isLoading: false, addresses: addresses));
    } catch (e, st) {
      _logger.e('Failed to load addresses', error: e, stackTrace: st);
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load addresses.',
      ));
    }
  }

  Future<void> addAddress({
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
  }) async {
    emit(this.state.copyWith(isSaving: true, errorMessage: '', isSaveSuccess: false));

    try {
      await _firebaseService.addAddress(
        streetAddress: streetAddress,
        city: city,
        state: state,
        zipCode: zipCode,
      );
      _logger.i('Address added successfully');
      emit(this.state.copyWith(isSaving: false, isSaveSuccess: true));
    } catch (e, st) {
      _logger.e('Failed to add address', error: e, stackTrace: st);
      emit(this.state.copyWith(
        isSaving: false,
        errorMessage: 'Failed to save address.',
      ));
    }
  }

  Future<void> updateAddress({
    required String addressId,
    required String streetAddress,
    required String city,
    required String state,
    required String zipCode,
  }) async {
    emit(this.state.copyWith(isSaving: true, errorMessage: '', isSaveSuccess: false));

    try {
      await _firebaseService.updateAddress(
        addressId: addressId,
        streetAddress: streetAddress,
        city: city,
        state: state,
        zipCode: zipCode,
      );
      _logger.i('Address updated successfully');
      emit(this.state.copyWith(isSaving: false, isSaveSuccess: true));
    } catch (e, st) {
      _logger.e('Failed to update address', error: e, stackTrace: st);
      emit(this.state.copyWith(
        isSaving: false,
        errorMessage: 'Failed to update address.',
      ));
    }
  }
}
