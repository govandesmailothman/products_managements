import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';

/// Concrete implementation of domain [ProductRepository].
/// Coordinates remote and local data sources according to Clean Architecture.
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({ProductRemoteDataSource? remoteDataSource})
      : remoteDataSource =
            remoteDataSource ?? ProductRemoteDataSourceImpl();

  @override
  Future<List<Product>> getProducts() async {
    return await remoteDataSource.getProducts();
  }

  @override
  Future<Product> createProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  }) async {
    return await remoteDataSource.createProduct(
      title: title,
      price: price,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
