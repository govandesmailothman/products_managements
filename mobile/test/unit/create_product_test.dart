import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/products/domain/entities/product.dart';
import 'package:mobile/features/products/domain/repositories/product_repository.dart';
import 'package:mobile/features/products/domain/usecases/create_product.dart';

class MockProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async => [];

  @override
  Future<Product> createProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  }) async {
    return Product(
      id: 101,
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}

void main() {
  group('CreateProduct UseCase', () {
    late MockProductRepository repository;
    late CreateProduct useCase;

    setUp(() {
      repository = MockProductRepository();
      useCase = CreateProduct(repository);
    });

    test('creates product when params are valid', () async {
      const params = CreateProductParams(
        title: 'Mechanical Keyboard',
        price: 120.0,
        description: 'RGB Backlit',
        imageUrl: 'https://example.com/keyboard.png',
      );

      final result = await useCase(params);

      expect(result.id, equals(101));
      expect(result.title, equals('Mechanical Keyboard'));
      expect(result.price, equals(120.0));
    });

    test('throws ArgumentError when title is empty', () async {
      const params = CreateProductParams(title: '   ', price: 50.0);

      expect(() => useCase(params), throwsA(isA<ArgumentError>()));
    });

    test('throws ArgumentError when price is negative', () async {
      const params = CreateProductParams(title: 'Valid Title', price: -10.0);

      expect(() => useCase(params), throwsA(isA<ArgumentError>()));
    });
  });
}
