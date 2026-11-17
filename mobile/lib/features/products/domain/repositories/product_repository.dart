import '../entities/product.dart';

/// Domain contract defining product data operations.
/// Follows Dependency Inversion Principle (DIP).
abstract class ProductRepository {
  /// Retrieves a list of all products.
  Future<List<Product>> getProducts();

  /// Creates a new product and returns the created entity.
  Future<Product> createProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  });
}
