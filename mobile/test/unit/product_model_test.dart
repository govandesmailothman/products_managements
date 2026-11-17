import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/features/products/models/product_model.dart';

void main() {
  group('Product Model Tests', () {
    test('fromJson deserializes complete JSON successfully', () {
      final json = {
        'id': 10,
        'title': 'Ergonomic Desk Chair',
        'description': 'High-back mesh chair with lumbar support.',
        'price': 249.99,
        'image_url': 'https://example.com/chair.jpg',
        'created_at': '2026-11-16T10:00:00.000Z',
        'updated_at': '2026-11-16T10:00:00.000Z',
      };

      final product = Product.fromJson(json);

      expect(product.id, equals(10));
      expect(product.title, equals('Ergonomic Desk Chair'));
      expect(
        product.description,
        equals('High-back mesh chair with lumbar support.'),
      );
      expect(product.price, equals(249.99));
      expect(product.imageUrl, equals('https://example.com/chair.jpg'));
      expect(product.createdAt, isNotNull);
      expect(product.updatedAt, isNotNull);
    });

    test('fromJson handles null description and null image_url safely', () {
      final json = {
        'id': 42,
        'title': 'Minimalist Mousepad',
        'description': null,
        'price': 15.0,
        'image_url': null,
      };

      final product = Product.fromJson(json);

      expect(product.id, equals(42));
      expect(product.title, equals('Minimalist Mousepad'));
      expect(product.description, isNull);
      expect(product.price, equals(15.0));
      expect(product.imageUrl, isNull);
      expect(product.createdAt, isNull);
    });

    test('fromJson handles string and integer prices gracefully', () {
      final jsonStringPrice = {'id': '1', 'title': 'USB Hub', 'price': '39.50'};
      final jsonIntPrice = {'id': 2, 'title': 'HDMI Cable', 'price': 20};

      final product1 = Product.fromJson(jsonStringPrice);
      final product2 = Product.fromJson(jsonIntPrice);

      expect(product1.id, equals(1));
      expect(product1.price, equals(39.50));
      expect(product2.id, equals(2));
      expect(product2.price, equals(20.0));
    });

    test('toJson serializes product accurately', () {
      const product = Product(
        id: 5,
        title: 'Wireless Keyboard',
        description: 'Compact mechanical keyboard',
        price: 89.99,
        imageUrl: 'https://example.com/keyboard.jpg',
      );

      final json = product.toJson();

      expect(json['id'], equals(5));
      expect(json['title'], equals('Wireless Keyboard'));
      expect(json['description'], equals('Compact mechanical keyboard'));
      expect(json['price'], equals(89.99));
      expect(json['image_url'], equals('https://example.com/keyboard.jpg'));
    });

    test('copyWith creates modified copy with preserved unchanged fields', () {
      const original = Product(id: 1, title: 'Original Title', price: 50.0);

      final updated = original.copyWith(title: 'Updated Title', price: 75.0);

      expect(updated.id, equals(1));
      expect(updated.title, equals('Updated Title'));
      expect(updated.price, equals(75.0));
    });
  });
}
