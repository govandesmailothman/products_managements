import '../../../../core/usecases/usecase.dart';
import '../entities/product.dart';
import '../repositories/product_repository.dart';

/// Use case responsible for retrieving all products.
class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  const GetProducts(this.repository);

  @override
  Future<List<Product>> call([NoParams params = const NoParams()]) {
    return repository.getProducts();
  }
}
