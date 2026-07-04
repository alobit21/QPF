import 'package:freezed_annotation/freezed_annotation.dart';

part 'amenity_model.freezed.dart';
part 'amenity_model.g.dart';

@freezed
abstract class Amenity with _$Amenity {
  const factory Amenity({
    required String id,
    required String name,
    required String icon,
  }) = _Amenity;

  factory Amenity.fromJson(Map<String, dynamic> json) => _$AmenityFromJson(json);
}
