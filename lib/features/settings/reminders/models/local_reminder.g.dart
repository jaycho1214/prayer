// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_reminder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalReminderAdapter extends TypeAdapter<LocalReminder> {
  @override
  final int typeId = 1;

  @override
  LocalReminder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalReminder(
      title: fields[0] as String,
      body: fields[1] as String,
      days: (fields[2] as List).cast<int>(),
      time: fields[3] as TimeOfDay,
    );
  }

  @override
  void write(BinaryWriter writer, LocalReminder obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.days)
      ..writeByte(3)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalReminderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
