import 'package:flutter/material.dart';

class HomeItemCardModel {
  final String imageUrl;
  late final ImageProvider imageProvider;
  final String date;
  final String category;

  HomeItemCardModel({
    required this.imageUrl,
    required this.date,
    required this.category,
  }) {
    if (imageUrl.contains("http")) {
      imageProvider = NetworkImage(imageUrl);
    } else {
      imageProvider = AssetImage(imageUrl);
    }
  }
}
