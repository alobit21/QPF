// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'office_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Office _$OfficeFromJson(Map<String, dynamic> json) => _Office(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  address: json['address'] as String,
  city: json['city'] as String,
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  pricePerHour: (json['pricePerHour'] as num?)?.toDouble(),
  size: (json['size'] as num?)?.toInt(),
  availableRooms: (json['availableRooms'] as num?)?.toInt(),
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  isActive: json['isActive'] as bool?,
);

Map<String, dynamic> _$OfficeToJson(_Office instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'address': instance.address,
  'city': instance.city,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'pricePerHour': instance.pricePerHour,
  'size': instance.size,
  'availableRooms': instance.availableRooms,
  'images': instance.images,
  'isActive': instance.isActive,
};
