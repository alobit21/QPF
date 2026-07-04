import 'package:freezed_annotation/freezed_annotation.dart';
import 'amenity_model.dart';
import 'slot_model.dart';

part 'office_model.freezed.dart';
part 'office_model.g.dart';

double? _priceFromJson(dynamic value) {
  if (value == null) return null;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

@freezed
abstract class Office with _$Office {
  const factory Office({
    required String id,
    required String name,
    required String description,
    required String address,
    required String city,
    double? latitude,
    double? longitude,
    @JsonKey(name: 'pricePerHour', fromJson: _priceFromJson) double? pricePerHour,
    int? size,
    int? availableRooms,
    List<String>? images,
    bool? isActive,
    List<Amenity>? amenities,
    List<Slot>? slots,
  }) = _Office;

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
}
