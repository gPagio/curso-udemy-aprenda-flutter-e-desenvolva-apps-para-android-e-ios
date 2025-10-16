import 'dart:ui' show Color;

import 'package:flutter/material.dart' show Colors;

class Category {
  final String id;
  final String title;
  final Color color;

  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });
}
