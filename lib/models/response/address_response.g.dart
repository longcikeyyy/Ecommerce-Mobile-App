// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressResponseModel _$AddressResponseModelFromJson(
  Map<String, dynamic> json,
) => AddressResponseModel(
  id: json['id'] as String,
  streetAddress: json['streetAddress'] as String,
  city: json['city'] as String,
  state: json['state'] as String,
  zipCode: json['zipCode'] as String,
);

Map<String, dynamic> _$AddressResponseModelToJson(
  AddressResponseModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'streetAddress': instance.streetAddress,
  'city': instance.city,
  'state': instance.state,
  'zipCode': instance.zipCode,
};
