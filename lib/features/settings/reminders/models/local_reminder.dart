import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'local_reminder.g.dart';

@HiveType(typeId: 1)
class LocalReminder extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String body;

  @HiveField(2)
  List<int> days;

  @HiveField(3)
  TimeOfDay time;

  LocalReminder({
    required this.title,
    required this.body,
    required this.days,
    required this.time,
  });
}
