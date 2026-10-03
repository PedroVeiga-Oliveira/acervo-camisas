import 'package:flutter/material.dart';

import '../models/shirt.dart';
import 'shirt_art.dart';

class ShirtCard extends StatelessWidget {
  const ShirtCard({
    super.key,
    required this.shirt,
    required this.onTap,
    required this.onEdit,
  });

  final Shirt shirt;
  final VoidCallback onTap;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
          child: Row(
            children: [
              SizedBox(
                width: 96,
                child: ShirtArt(color: shirt.primaryColor, compact: true),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shirt.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(shirt.team),
                    const SizedBox(height: 4),
                    Text(
                      '${shirt.season} • '
                      'Tam. ${shirt.size}',
                    ),
                    const SizedBox(height: 8),
                    Chip(label: Text(shirt.condition)),
                  ],
                ),
              ),
              Tooltip(
                message: 'Editar camisa',
                child: IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_outlined),
                  constraints: const BoxConstraints(
                    minWidth: 48,
                    minHeight: 48,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
