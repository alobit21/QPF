import 'package:freezed_annotation/freezed_annotation.dart';

part 'slot_model.freezed.dart';
part 'slot_model.g.dart';

@freezed
abstract class Slot with _$Slot {
  const factory Slot({
    required String id,
    required String officeId,
    required String date,
    required String startTime,
    required String endTime,
    required String roomNumber,
    @Default(true) bool isAvailable,
  }) = _Slot;

  factory Slot.fromJson(Map<String, dynamic> json) => _$SlotFromJson(json);
}
