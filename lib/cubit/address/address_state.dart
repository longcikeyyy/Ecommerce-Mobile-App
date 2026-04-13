import 'package:ecommerce_mobile_app/models/response/address_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_state.freezed.dart';

@freezed
class AddressState with _$AddressState {
  const factory AddressState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default('') String errorMessage,
    @Default(false) bool isSaveSuccess,
    @Default([]) List<AddressResponseModel> addresses,
  }) = _AddressState;
}
