import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/product_provider.dart';
import 'screens/product_list_screen.dart';

void main() {
  runApp(const StockCircleApp());
}

class StockCircleApp extends StatelessWidget {
  const StockCircleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider()..loadProducts(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StockCircle',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        themeMode: ThemeMode.system,
        home: const ProductListScreen(),
      ),
    );
  }
}
