import 'package:ecommerce_mobile_app/models/response/category_response.dart';
import 'package:ecommerce_mobile_app/models/response/product_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage,
    @Default([]) List<CategoryResponseModel> categories,
    @Default(false) bool isTopSellingLoading,
    @Default('') String topSellingErrorMessage,
    @Default([]) List<ProductResponseModel> topSellingProducts,
  }) = _HomeState;
}
