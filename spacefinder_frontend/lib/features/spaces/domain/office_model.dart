import 'package:freezed_annotation/freezed_annotation.dart';

part 'office_model.freezed.dart';
part 'office_model.g.dart';

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
    @JsonKey(name: 'pricePerHour') double? pricePerHour,
    int? size,
    int? availableRooms,
    List<String>? images,
    bool? isActive,
  }) = _Office;

  factory Office.fromJson(Map<String, dynamic> json) => _$OfficeFromJson(json);
}
