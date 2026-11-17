import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/network/api_client.dart';
import 'package:mobile/features/products/models/product_model.dart';
import 'package:mobile/features/products/providers/product_provider.dart';
import 'package:mobile/features/products/repositories/product_repository.dart';

/// Mock repository implementation for predictable unit testing.
class MockSuccessProductRepository extends ProductRepository {
  final List<Product> mockProducts;

  MockSuccessProductRepository(this.mockProducts);

  @override
  Future<List<Product>> getProducts() async {
    return mockProducts;
  }

  @override
  Future<Product> createProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  }) async {
    return Product(
      id: 999,
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

class MockFailingProductRepository extends ProductRepository {
  final String errorMessage;

  MockFailingProductRepository([
    this.errorMessage = 'Network connection failed',
  ]);

  @override
  Future<List<Product>> getProducts() async {
    throw ApiException(errorMessage, 500);
  }

  @override
  Future<Product> createProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  }) async {
    throw ApiException(errorMessage, 422);
  }
}

void main() {
  group('ProductProvider State Management Tests', () {
    test('initial state is correct', () {
      final provider = ProductProvider();

      expect(provider.products, isEmpty);
      expect(provider.status, equals(ProductStatus.initial));
      expect(provider.isLoading, isFalse);
      expect(provider.hasError, isFalse);
      expect(provider.errorMessage, isNull);
    });

    test(
      'fetchProducts transitions to loaded state with products on success',
      () async {
        final sampleProducts = [
          const Product(id: 1, title: 'Item 1', price: 29.99),
          const Product(id: 2, title: 'Item 2', price: 49.99),
        ];

        final provider = ProductProvider(
          repository: MockSuccessProductRepository(sampleProducts),
        );

        final statusHistory = <ProductStatus>[];
        provider.addListener(() {
          statusHistory.add(provider.status);
        });

        await provider.fetchProducts();

        expect(statusHistory, contains(ProductStatus.loading));
        expect(provider.status, equals(ProductStatus.loaded));
        expect(provider.products.length, equals(2));
        expect(provider.products.first.title, equals('Item 1'));
        expect(provider.hasError, isFalse);
        expect(provider.errorMessage, isNull);
      },
    );

    test('fetchProducts transitions to error state on API failure', () async {
      final provider = ProductProvider(
        repository: MockFailingProductRepository('Server unavailable'),
      );

      await provider.fetchProducts();

      expect(provider.status, equals(ProductStatus.error));
      expect(provider.hasError, isTrue);
      expect(provider.errorMessage, equals('Server unavailable'));
      expect(provider.products, isEmpty);
    });

    test(
      'addProduct prepends newly created product and maintains loaded state',
      () async {
        final initialProducts = [
          const Product(id: 1, title: 'Existing Product', price: 10.0),
        ];

        final provider = ProductProvider(
          repository: MockSuccessProductRepository(initialProducts),
        );

        await provider.fetchProducts();
        expect(provider.products.length, equals(1));

        final success = await provider.addProduct(
          title: 'New Wireless Mouse',
          price: 35.0,
          description: 'Smooth precision mouse',
        );

        expect(success, isTrue);
        expect(provider.products.length, equals(2));
        expect(provider.products.first.title, equals('New Wireless Mouse'));
        expect(provider.products.first.id, equals(999));
      },
    );

    test('addProduct handles failure gracefully', () async {
      final provider = ProductProvider(
        repository: MockFailingProductRepository('Validation failed'),
      );

      final success = await provider.addProduct(title: '', price: -5.0);

      expect(success, isFalse);
      expect(provider.errorMessage, equals('Validation failed'));
    });
  });
}
