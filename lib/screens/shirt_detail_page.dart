import 'package:flutter/material.dart';

import '../models/shirt.dart';
import '../widgets/shirt_art.dart';

class ShirtDetailPage extends StatelessWidget {
  const ShirtDetailPage({super.key, required this.shirt});

  final Shirt shirt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes da camisa')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          ShirtArt(color: shirt.primaryColor),
                          const SizedBox(height: 20),
                          Text(
                            shirt.name,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            shirt.team,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _InfoRow(
                            label: 'Temporada',
                            value: '${shirt.season}',
                          ),
                          const Divider(height: 24),
                          _InfoRow(label: 'Tamanho', value: shirt.size),
                          const Divider(height: 24),
                          _InfoRow(
                            label: 'Conservação',
                            value: shirt.condition,
                          ),
                          const Divider(height: 24),
                          _InfoRow(
                            label: 'Observações',
                            value: shirt.notes.isEmpty
                                ? 'Nenhuma.'
                                : shirt.notes,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(label, style: Theme.of(context).textTheme.labelLarge),
        ),
        const SizedBox(width: 12),
        Expanded(child: Text(value)),
      ],
    );
  }
}
