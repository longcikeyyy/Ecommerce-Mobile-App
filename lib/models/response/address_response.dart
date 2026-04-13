import 'package:json_annotation/json_annotation.dart';

part 'address_response.g.dart';

@JsonSerializable()
class AddressResponseModel {
  final String id;
  final String streetAddress;
  final String city;
  final String state;
  final String zipCode;

  AddressResponseModel({
    required this.id,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.zipCode,
  });

  factory AddressResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseModelToJson(this);

  String get fullAddress => '$streetAddress, $city, $state $zipCode';
}
