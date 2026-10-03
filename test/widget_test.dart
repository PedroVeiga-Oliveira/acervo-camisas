import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:acervo_camisas/models/shirt.dart';
import 'package:acervo_camisas/screens/catalog_page.dart';
import 'package:acervo_camisas/screens/shirt_detail_page.dart';
import 'package:acervo_camisas/screens/shirt_form_page.dart';

void main() {
  testWidgets('mostra o estado vazio no catalogo quando nao ha camisas', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(home: CatalogPage(initialShirts: const <Shirt>[])),
    );

    expect(find.text('Nenhuma camisa cadastrada'), findsOneWidget);

    expect(find.text('Adicionar camisa'), findsOneWidget);
  });

  testWidgets('validacao impede envio com campos obrigatorios vazios', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ShirtFormPage()));

    final listView = find.byType(ListView);

    final cadastrarButton = find.widgetWithText(FilledButton, 'Cadastrar');

    await tester.drag(listView, const Offset(0, -1000));

    await tester.pumpAndSettle();

    expect(cadastrarButton, findsOneWidget);

    await tester.tap(cadastrarButton);

    await tester.pumpAndSettle();

    await tester.drag(listView, const Offset(0, 1000));

    await tester.pumpAndSettle();

    expect(find.text('Informe o nome da camisa.'), findsOneWidget);

    expect(find.text('Informe o clube ou seleção.'), findsOneWidget);

    expect(find.text('Informe a temporada.'), findsOneWidget);
  });

  testWidgets('detalhe mostra os dados da camisa selecionada', (tester) async {
    final shirt = Shirt(
      id: '10',
      name: 'Camisa especial 2025',
      team: 'Flamengo',
      season: 2025,
      size: 'M',
      condition: 'Nova',
      notes: 'Edição especial.',
      primaryColor: const Color(0xFFB71C1C),
    );

    await tester.pumpWidget(MaterialApp(home: ShirtDetailPage(shirt: shirt)));

    expect(find.text('Camisa especial 2025'), findsOneWidget);

    expect(find.text('Flamengo'), findsOneWidget);

    expect(find.text('2025'), findsOneWidget);

    expect(find.text('Edição especial.'), findsOneWidget);
  });
}
