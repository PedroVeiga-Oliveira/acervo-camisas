import 'package:flutter/material.dart';

import '../models/shirt.dart';
import '../widgets/empty_state.dart';
import '../widgets/shirt_card.dart';
import 'shirt_detail_page.dart';
import 'shirt_form_page.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key, this.initialShirts});

  final List<Shirt>? initialShirts;

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  late final List<Shirt> _shirts = [
    if (widget.initialShirts != null)
      ...widget.initialShirts!
    else ...[
      Shirt(
        id: '1',
        name: 'Camisa titular 2024',
        team: 'Flamengo',
        season: 2024,
        size: 'M',
        condition: 'Muito boa',
        notes: 'Peça usada em poucas ocasiões.',
        primaryColor: const Color(0xFFB71C1C),
      ),
      Shirt(
        id: '2',
        name: 'Camisa principal 2023',
        team: 'Manchester City',
        season: 2023,
        size: 'G',
        condition: 'Nova',
        notes: 'Ainda com etiqueta.',
        primaryColor: const Color(0xFF1976D2),
      ),
    ],
  ];

  int _nextId = 3;

  Future<void> _openForm({Shirt? shirt}) async {
    final result = await Navigator.of(context).push<Shirt>(
      MaterialPageRoute(builder: (_) => ShirtFormPage(initialShirt: shirt)),
    );

    if (!mounted || result == null) {
      return;
    }

    setState(() {
      if (shirt == null) {
        _shirts.add(
          Shirt(
            id: '${_nextId++}',
            name: result.name,
            team: result.team,
            season: result.season,
            size: result.size,
            condition: result.condition,
            notes: result.notes,
            primaryColor: result.primaryColor,
          ),
        );

        return;
      }

      final index = _shirts.indexWhere((item) => item.id == shirt.id);

      if (index != -1) {
        _shirts[index] = Shirt(
          id: shirt.id,
          name: result.name,
          team: result.team,
          season: result.season,
          size: result.size,
          condition: result.condition,
          notes: result.notes,
          primaryColor: result.primaryColor,
        );
      }
    });
  }

  void _clearCatalog() {
    if (_shirts.isEmpty) {
      return;
    }

    setState(_shirts.clear);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Catálogo limpo.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acervo de Camisas'),
        actions: [
          Tooltip(
            message: 'Limpar catálogo',
            child: IconButton(
              onPressed: _clearCatalog,
              icon: const Icon(Icons.delete_sweep_outlined),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        tooltip: 'Adicionar camisa',
        icon: const Icon(Icons.add),
        label: const Text('Adicionar'),
      ),
      body: SafeArea(
        child: _shirts.isEmpty
            ? EmptyState(onAdd: () => _openForm())
            : LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 720 ? 2 : 1;

                  final horizontalPadding = constraints.maxWidth >= 720
                      ? 32.0
                      : 16.0;

                  return ListView(
                    padding: EdgeInsets.fromLTRB(
                      horizontalPadding,
                      20,
                      horizontalPadding,
                      96,
                    ),
                    children: [
                      Text(
                        '${_shirts.length} '
                        '${_shirts.length == 1 ? 'camisa cadastrada' : 'camisas cadastradas'}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _shirts.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          mainAxisExtent: 168,
                        ),
                        itemBuilder: (context, index) {
                          final shirt = _shirts[index];

                          return ShirtCard(
                            shirt: shirt,
                            onTap: () {
                              Navigator.of(context).push<void>(
                                MaterialPageRoute(
                                  builder: (_) => ShirtDetailPage(shirt: shirt),
                                ),
                              );
                            },
                            onEdit: () => _openForm(shirt: shirt),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
