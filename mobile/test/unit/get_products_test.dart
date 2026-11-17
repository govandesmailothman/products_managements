import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/core/usecases/usecase.dart';
import 'package:mobile/features/products/domain/entities/product.dart';
import 'package:mobile/features/products/domain/repositories/product_repository.dart';
import 'package:mobile/features/products/domain/usecases/get_products.dart';

class MockProductRepository implements ProductRepository {
  final List<Product> products;

  MockProductRepository(this.products);

  @override
  Future<List<Product>> getProducts() async => products;

  @override
  Future<Product> createProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  }) async {
    throw UnimplementedError();
  }
}

void main() {
  group('GetProducts UseCase', () {
    test('fetches products successfully from repository', () async {
      const mockList = [
        Product(id: 1, title: 'Test Product 1', price: 99.99),
        Product(id: 2, title: 'Test Product 2', price: 149.99),
      ];

      final repository = MockProductRepository(mockList);
      final useCase = GetProducts(repository);

      final result = await useCase(const NoParams());

      expect(result.length, equals(2));
      expect(result.first.title, equals('Test Product 1'));
      expect(result.last.price, equals(149.99));
    });
  });
}
