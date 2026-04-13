import 'package:json_annotation/json_annotation.dart';

part 'product_response.g.dart';

@JsonSerializable()
class ProductResponseModel {
  final String id;
  final String name;
  final String image;
  final num price;
  final num? oldPrice;
  final bool isFavorite;

  ProductResponseModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.oldPrice,
    this.isFavorite = false,
  });

  factory ProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseModelToJson(this);
}
