# Acervo de Camisas

Aplicativo Flutter local para cadastrar e consultar
um acervo pessoal de camisas de futebol.

## Objetivo

Permitir visualizar uma coleção de camisas, abrir
os detalhes, cadastrar novas peças e editar itens
existentes.

Os dados ficam somente em memória durante a execução,
pois persistência não faz parte do escopo deste trabalho.

## Tecnologias

- Flutter
- Dart
- Material 3
- Android

## Organização

```text
lib/
  models/
    shirt.dart
  screens/
    catalog_page.dart
    shirt_detail_page.dart
    shirt_form_page.dart
  theme/
    app_theme.dart
  widgets/
    empty_state.dart
    shirt_art.dart
    shirt_card.dart
  main.dart

test/
  widget_test.dart
```

## Como executar

1. Ter o Flutter configurado para Android.
2. Clonar o repositório.
3. Entrar na pasta do projeto.
4. Executar:

```bash
flutter pub get
```

5. Executar os testes:

```bash
flutter test
```

6. Executar o aplicativo:

```bash
flutter run
```

## Conferência da versão final

Antes da entrega, executar:

```bash
dart format .
flutter analyze
flutter test
flutter build apk
```

## APK

O APK Android é gerado em:

```text
build/app/outputs/flutter-apk/
```