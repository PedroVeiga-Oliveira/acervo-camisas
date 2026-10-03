import 'package:flutter/material.dart';

import '../models/shirt.dart';
import '../widgets/shirt_art.dart';

class ShirtFormPage extends StatefulWidget {
  const ShirtFormPage({super.key, this.initialShirt});

  final Shirt? initialShirt;

  @override
  State<ShirtFormPage> createState() => _ShirtFormPageState();
}

class _ShirtFormPageState extends State<ShirtFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;

  late final TextEditingController _teamController;

  late final TextEditingController _seasonController;

  late final TextEditingController _notesController;

  final _sizes = ['P', 'M', 'G', 'GG'];

  final _conditions = ['Nova', 'Muito boa', 'Boa', 'Usada'];

  String _size = 'M';
  String _condition = 'Muito boa';

  Color _primaryColor = const Color(0xFF1557A6);

  bool get _editing => widget.initialShirt != null;

  @override
  void initState() {
    super.initState();

    final shirt = widget.initialShirt;

    _nameController = TextEditingController(text: shirt?.name ?? '');

    _teamController = TextEditingController(text: shirt?.team ?? '');

    _seasonController = TextEditingController(
      text: shirt == null ? '' : '${shirt.season}',
    );

    _notesController = TextEditingController(text: shirt?.notes ?? '');

    if (shirt != null) {
      _size = shirt.size;
      _condition = shirt.condition;
      _primaryColor = shirt.primaryColor;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _teamController.dispose();
    _seasonController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final id = widget.initialShirt?.id ?? '';

    Navigator.of(context).pop(
      Shirt(
        id: id,
        name: _nameController.text.trim(),
        team: _teamController.text.trim(),
        season: int.parse(_seasonController.text.trim()),
        size: _size,
        condition: _condition,
        notes: _notesController.text.trim(),
        primaryColor: _primaryColor,
      ),
    );
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe $label.';
    }

    return null;
  }

  String? _validateSeason(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Informe a temporada.';
    }

    final year = int.tryParse(value.trim());

    if (year == null || year < 1900 || year > 2100) {
      return 'Use um ano entre 1900 e 2100.';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_editing ? 'Editar camisa' : 'Nova camisa')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            children: [
              Center(child: ShirtArt(color: _primaryColor, compact: true)),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome da camisa',
                  hintText: 'Ex.: Camisa titular 2025',
                ),
                validator: (value) => _required(value, 'o nome da camisa'),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _teamController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Clube ou seleção',
                  hintText: 'Ex.: Flamengo',
                ),
                validator: (value) => _required(value, 'o clube ou seleção'),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _seasonController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Temporada',
                  hintText: 'Ex.: 2025',
                ),
                validator: _validateSeason,
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _size,
                decoration: const InputDecoration(labelText: 'Tamanho'),
                items: _sizes
                    .map(
                      (size) =>
                          DropdownMenuItem(value: size, child: Text(size)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _size = value);
                  }
                },
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<String>(
                initialValue: _condition,
                decoration: const InputDecoration(labelText: 'Conservação'),
                items: _conditions
                    .map(
                      (condition) => DropdownMenuItem(
                        value: condition,
                        child: Text(condition),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _condition = value);
                  }
                },
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Observações',
                  hintText: 'Ex.: presente de aniversário',
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<Color>(
                initialValue: _primaryColor,
                decoration: const InputDecoration(labelText: 'Cor da camisa'),
                items: const [
                  DropdownMenuItem(
                    value: Color(0xFF1557A6),
                    child: Text('Azul'),
                  ),
                  DropdownMenuItem(
                    value: Color(0xFFB71C1C),
                    child: Text('Vermelho'),
                  ),
                  DropdownMenuItem(
                    value: Color(0xFF1B5E20),
                    child: Text('Verde'),
                  ),
                  DropdownMenuItem(
                    value: Color(0xFF212121),
                    child: Text('Preto'),
                  ),
                  DropdownMenuItem(
                    value: Color.fromARGB(255, 248, 248, 248),
                    child: Text('Branco'),
                  ),
                  DropdownMenuItem(
                    value: Color.fromARGB(255, 255, 233, 34),
                    child: Text('Amarelo'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _primaryColor = value);
                  }
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save_outlined),
                      label: Text(_editing ? 'Salvar edição' : 'Cadastrar'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
