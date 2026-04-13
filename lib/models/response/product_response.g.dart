// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponseModel _$ProductResponseModelFromJson(
  Map<String, dynamic> json,
) => ProductResponseModel(
  id: json['id'] as String,
  name: json['name'] as String,
  image: json['image'] as String,
  price: json['price'] as num,
  oldPrice: json['oldPrice'] as num?,
  isFavorite: json['isFavorite'] as bool? ?? false,
);

Map<String, dynamic> _$ProductResponseModelToJson(
  ProductResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'image': instance.image,
  'price': instance.price,
  'oldPrice': instance.oldPrice,
  'isFavorite': instance.isFavorite,
};
