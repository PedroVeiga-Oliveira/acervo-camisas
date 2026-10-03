import 'package:flutter/material.dart';

class Shirt {
  Shirt({
    required this.id,
    required this.name,
    required this.team,
    required this.season,
    required this.size,
    required this.condition,
    required this.notes,
    required this.primaryColor,
  });

  final String id;
  final String name;
  final String team;
  final int season;
  final String size;
  final String condition;
  final String notes;
  final Color primaryColor;

  Shirt copyWith({
    String? name,
    String? team,
    int? season,
    String? size,
    String? condition,
    String? notes,
    Color? primaryColor,
  }) {
    return Shirt(
      id: id,
      name: name ?? this.name,
      team: team ?? this.team,
      season: season ?? this.season,
      size: size ?? this.size,
      condition: condition ?? this.condition,
      notes: notes ?? this.notes,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}
