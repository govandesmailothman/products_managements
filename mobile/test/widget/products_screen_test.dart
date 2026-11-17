import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/products/models/product_model.dart';
import 'package:mobile/features/products/providers/product_provider.dart';
import 'package:mobile/features/products/screens/products_screen.dart';
import 'package:mobile/features/products/widgets/product_card.dart';
import 'package:provider/provider.dart';

import '../unit/product_provider_test.dart';

Widget createTestWidget(ProductProvider provider) {
  return MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home: ChangeNotifierProvider<ProductProvider>.value(
      value: provider,
      child: const ProductsScreen(),
    ),
  );
}

void main() {
  group('ProductsScreen Widget Tests', () {
    testWidgets('displays products in ListView when loaded', (tester) async {
      final sampleProducts = [
        const Product(
          id: 1,
          title: 'Mechanical Keyboard',
          description: 'Tactile switch keyboard',
          price: 99.99,
        ),
        const Product(
          id: 2,
          title: 'Gaming Mouse',
          description: 'RGB optical mouse',
          price: 49.99,
        ),
      ];

      final provider = ProductProvider(
        repository: MockSuccessProductRepository(sampleProducts),
      );

      await tester.pumpWidget(createTestWidget(provider));
      // Settle the post-frame callback fetchProducts()
      await tester.pumpAndSettle();

      expect(find.text('Products Management'), findsOneWidget);
      expect(find.byType(ProductCard), findsNWidgets(2));
      expect(find.text('Mechanical Keyboard'), findsOneWidget);
      expect(find.text('\$99.99'), findsOneWidget);
      expect(find.text('Gaming Mouse'), findsOneWidget);
      expect(find.text('\$49.99'), findsOneWidget);
    });

    testWidgets('displays empty state when catalog is empty', (tester) async {
      final provider = ProductProvider(
        repository: MockSuccessProductRepository([]),
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('No Products Found'), findsOneWidget);
      expect(find.byIcon(Icons.inventory_2_outlined), findsOneWidget);
    });

    testWidgets('displays error state with retry button on failure', (
      tester,
    ) async {
      final provider = ProductProvider(
        repository: MockFailingProductRepository('Network connection failed'),
      );

      await tester.pumpWidget(createTestWidget(provider));
      await tester.pumpAndSettle();

      expect(find.text('Failed to load products'), findsOneWidget);
      expect(find.text('Network connection failed'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
    });
  });
}
