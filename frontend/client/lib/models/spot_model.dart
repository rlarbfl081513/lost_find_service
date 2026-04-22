import 'package:flutter/material.dart';

class SpotModel {
  final String name;
  final String address;
  final int time;
  final Offset position;

  const SpotModel({
    required this.name,
    required this.address,
    required this.time,
    required this.position,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
      'time': time,
      'position': position,
    };
  }

  factory SpotModel.fromMap(Map<String, dynamic> map) {
    return SpotModel(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      time: map['time'] ?? 0,
      position: map['position'] ?? const Offset(0, 0),
    );
  }
}
