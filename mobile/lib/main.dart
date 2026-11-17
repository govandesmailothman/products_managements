import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/products/presentation/providers/product_provider.dart';
import 'features/products/presentation/screens/products_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProductsManagementApp());
}

class ProductsManagementApp extends StatelessWidget {
  const ProductsManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ProductProvider())],
      child: MaterialApp(
        title: 'Products Management',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2563EB), // Professional indigo/blue seed
            brightness: Brightness.light,
          ),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            scrolledUnderElevation: 1,
            centerTitle: false,
          ),
          cardTheme: const CardThemeData(
            elevation: 0,
            clipBehavior: Clip.antiAlias,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF2563EB),
                width: 1.5,
              ),
            ),
          ),
        ),
        home: const ProductsScreen(),
      ),
    );
  }
}
