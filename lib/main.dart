import 'package:flutter/material.dart';

import 'screens/catalog_page.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const AcervoCamisasApp());
}

class AcervoCamisasApp extends StatelessWidget {
  const AcervoCamisasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Acervo de Camisas',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const CatalogPage(),
    );
  }
}
