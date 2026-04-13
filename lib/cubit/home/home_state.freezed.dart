// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$HomeState {
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;
  List<CategoryResponseModel> get categories =>
      throw _privateConstructorUsedError;
  bool get isTopSellingLoading => throw _privateConstructorUsedError;
  String get topSellingErrorMessage => throw _privateConstructorUsedError;
  List<ProductResponseModel> get topSellingProducts =>
      throw _privateConstructorUsedError;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HomeStateCopyWith<HomeState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
  @useResult
  $Res call({
    bool isLoading,
    String errorMessage,
    List<CategoryResponseModel> categories,
    bool isTopSellingLoading,
    String topSellingErrorMessage,
    List<ProductResponseModel> topSellingProducts,
  });
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? categories = null,
    Object? isTopSellingLoading = null,
    Object? topSellingErrorMessage = null,
    Object? topSellingProducts = null,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: null == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            categories: null == categories
                ? _value.categories
                : categories // ignore: cast_nullable_to_non_nullable
                      as List<CategoryResponseModel>,
            isTopSellingLoading: null == isTopSellingLoading
                ? _value.isTopSellingLoading
                : isTopSellingLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            topSellingErrorMessage: null == topSellingErrorMessage
                ? _value.topSellingErrorMessage
                : topSellingErrorMessage // ignore: cast_nullable_to_non_nullable
                      as String,
            topSellingProducts: null == topSellingProducts
                ? _value.topSellingProducts
                : topSellingProducts // ignore: cast_nullable_to_non_nullable
                      as List<ProductResponseModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HomeStateImplCopyWith<$Res>
    implements $HomeStateCopyWith<$Res> {
  factory _$$HomeStateImplCopyWith(
    _$HomeStateImpl value,
    $Res Function(_$HomeStateImpl) then,
  ) = __$$HomeStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isLoading,
    String errorMessage,
    List<CategoryResponseModel> categories,
    bool isTopSellingLoading,
    String topSellingErrorMessage,
    List<ProductResponseModel> topSellingProducts,
  });
}

/// @nodoc
class __$$HomeStateImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$HomeStateImpl>
    implements _$$HomeStateImplCopyWith<$Res> {
  __$$HomeStateImplCopyWithImpl(
    _$HomeStateImpl _value,
    $Res Function(_$HomeStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? errorMessage = null,
    Object? categories = null,
    Object? isTopSellingLoading = null,
    Object? topSellingErrorMessage = null,
    Object? topSellingProducts = null,
  }) {
    return _then(
      _$HomeStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: null == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        categories: null == categories
            ? _value._categories
            : categories // ignore: cast_nullable_to_non_nullable
                  as List<CategoryResponseModel>,
        isTopSellingLoading: null == isTopSellingLoading
            ? _value.isTopSellingLoading
            : isTopSellingLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        topSellingErrorMessage: null == topSellingErrorMessage
            ? _value.topSellingErrorMessage
            : topSellingErrorMessage // ignore: cast_nullable_to_non_nullable
                  as String,
        topSellingProducts: null == topSellingProducts
            ? _value._topSellingProducts
            : topSellingProducts // ignore: cast_nullable_to_non_nullable
                  as List<ProductResponseModel>,
      ),
    );
  }
}

/// @nodoc

class _$HomeStateImpl implements _HomeState {
  const _$HomeStateImpl({
    this.isLoading = false,
    this.errorMessage = '',
    final List<CategoryResponseModel> categories = const [],
    this.isTopSellingLoading = false,
    this.topSellingErrorMessage = '',
    final List<ProductResponseModel> topSellingProducts = const [],
  }) : _categories = categories,
       _topSellingProducts = topSellingProducts;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMessage;
  final List<CategoryResponseModel> _categories;
  @override
  @JsonKey()
  List<CategoryResponseModel> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  @JsonKey()
  final bool isTopSellingLoading;
  @override
  @JsonKey()
  final String topSellingErrorMessage;
  final List<ProductResponseModel> _topSellingProducts;
  @override
  @JsonKey()
  List<ProductResponseModel> get topSellingProducts {
    if (_topSellingProducts is EqualUnmodifiableListView)
      return _topSellingProducts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topSellingProducts);
  }

  @override
  String toString() {
    return 'HomeState(isLoading: $isLoading, errorMessage: $errorMessage, categories: $categories, isTopSellingLoading: $isTopSellingLoading, topSellingErrorMessage: $topSellingErrorMessage, topSellingProducts: $topSellingProducts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            const DeepCollectionEquality().equals(
              other._categories,
              _categories,
            ) &&
            (identical(other.isTopSellingLoading, isTopSellingLoading) ||
                other.isTopSellingLoading == isTopSellingLoading) &&
            (identical(other.topSellingErrorMessage, topSellingErrorMessage) ||
                other.topSellingErrorMessage == topSellingErrorMessage) &&
            const DeepCollectionEquality().equals(
              other._topSellingProducts,
              _topSellingProducts,
            ));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isLoading,
    errorMessage,
    const DeepCollectionEquality().hash(_categories),
    isTopSellingLoading,
    topSellingErrorMessage,
    const DeepCollectionEquality().hash(_topSellingProducts),
  );

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      __$$HomeStateImplCopyWithImpl<_$HomeStateImpl>(this, _$identity);
}

abstract class _HomeState implements HomeState {
  const factory _HomeState({
    final bool isLoading,
    final String errorMessage,
    final List<CategoryResponseModel> categories,
    final bool isTopSellingLoading,
    final String topSellingErrorMessage,
    final List<ProductResponseModel> topSellingProducts,
  }) = _$HomeStateImpl;

  @override
  bool get isLoading;
  @override
  String get errorMessage;
  @override
  List<CategoryResponseModel> get categories;
  @override
  bool get isTopSellingLoading;
  @override
  String get topSellingErrorMessage;
  @override
  List<ProductResponseModel> get topSellingProducts;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HomeStateImplCopyWith<_$HomeStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
