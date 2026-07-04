// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Slot _$SlotFromJson(Map<String, dynamic> json) => _Slot(
  id: json['id'] as String,
  officeId: json['officeId'] as String,
  date: json['date'] as String,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  roomNumber: json['roomNumber'] as String,
  isAvailable: json['isAvailable'] as bool? ?? true,
);

Map<String, dynamic> _$SlotToJson(_Slot instance) => <String, dynamic>{
  'id': instance.id,
  'officeId': instance.officeId,
  'date': instance.date,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'roomNumber': instance.roomNumber,
  'isAvailable': instance.isAvailable,
};
