import 'package:flutter/material.dart';

enum MultiDaySegement {
  first,
  middle,
  last,
}

class CalendarEvent {
  String summary;
  String description;
  String location;
  String imagePath;
  DateTime startTime;
  DateTime endTime;
  int? recurrence;
  Color? color;
  bool isAllDay;
  bool isMultiDay;
  MultiDaySegement? multiDaySegement;
  bool isDone;
  Map<String, dynamic>? metadata;

  CalendarEvent(
    this.summary, {
    this.description = '',
    this.location = '',
    required this.imagePath,
    required this.startTime,
    required this.endTime,
    this.color = Colors.blue,
    this.isAllDay = false,
    this.isMultiDay = false,
    this.isDone = false,
    multiDaySegement,
    this.metadata,
    this.recurrence,
  });
}
