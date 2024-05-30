import 'package:flutter/material.dart';

class DepartureInfoModel {
  String country;
  String city;
  String airport;
  DateTime date;
  TimeOfDay time;

  DepartureInfoModel({
    required this.country,
    required this.city,
    required this.airport,
    required this.date,
    required this.time,
  });

  factory DepartureInfoModel.fromJson(Map<String, dynamic> json) {
    return DepartureInfoModel(
      country: json['country'],
      city: json['city'],
      airport: json['airport'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: json['time']['hour'],
        minute: json['time']['minute'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'city': city,
      'airport': airport,
      'date': date.toIso8601String(),
      'time': {
        'hour': time.hour,
        'minute': time.minute,
      },
    };
  }
}
