import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class CreateProductParams {
  final String title;
  final double price;
  final String? description;
  final String? imageUrl;

  const CreateProductParams({
    required this.title,
    required this.price,
    this.description,
    this.imageUrl,
  });
}

/// Use case responsible for validating and creating a new product.
class CreateProduct implements UseCase<Product, CreateProductParams> {
  final ProductRepository repository;

  const CreateProduct(this.repository);

  @override
  Future<Product> call(CreateProductParams params) {
    if (params.title.trim().isEmpty) {
      throw ArgumentError('Product title cannot be empty.');
    }
    if (params.price < 0) {
      throw ArgumentError('Product price cannot be negative.');
    }

    return repository.createProduct(
      title: params.title.trim(),
      price: params.price,
      description: params.description?.trim(),
      imageUrl: params.imageUrl?.trim(),
    );
  }
}
