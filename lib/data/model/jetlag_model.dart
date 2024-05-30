import 'package:flutter/material.dart';

class JetlagModel {
  final String homeCountry;
  final String destinationCountry;
  final TimeOfDay time;

  JetlagModel({
    required this.homeCountry,
    required this.destinationCountry,
    required this.time,
  });
}
