import 'package:flutter/foundation.dart';

import '../../../../core/network/api_client.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/create_product.dart';
import '../../domain/usecases/get_products.dart';

enum ProductStatus { initial, loading, loaded, error }

/// Presentation state manager managing UI states using Use Cases.
class ProductProvider extends ChangeNotifier {
  final GetProducts _getProductsUseCase;
  final CreateProduct _createProductUseCase;

  ProductProvider({
    ProductRepository? repository,
    GetProducts? getProductsUseCase,
    CreateProduct? createProductUseCase,
  })  : _getProductsUseCase = getProductsUseCase ??
            GetProducts(repository ?? ProductRepositoryImpl()),
        _createProductUseCase = createProductUseCase ??
            CreateProduct(repository ?? ProductRepositoryImpl());

  List<Product> _products = [];
  ProductStatus _status = ProductStatus.initial;
  String? _errorMessage;

  List<Product> get products => List.unmodifiable(_products);
  ProductStatus get status => _status;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == ProductStatus.loading;
  bool get hasError => _status == ProductStatus.error;
  bool get isEmpty => _status == ProductStatus.loaded && _products.isEmpty;

  /// Fetches products using [GetProducts] use case and updates UI state.
  Future<void> fetchProducts() async {
    _status = ProductStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedProducts = await _getProductsUseCase();
      _products = fetchedProducts;
      _status = ProductStatus.loaded;
      _errorMessage = null;
    } on ApiException catch (e) {
      _status = ProductStatus.error;
      _errorMessage = e.message;
    } catch (e) {
      _status = ProductStatus.error;
      _errorMessage =
          'An unexpected error occurred while fetching products: $e';
    } finally {
      notifyListeners();
    }
  }

  /// Adds a new product using [CreateProduct] use case.
  Future<bool> addProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  }) async {
    try {
      final params = CreateProductParams(
        title: title,
        price: price,
        description: description,
        imageUrl: imageUrl,
      );

      final newProduct = await _createProductUseCase(params);

      _products = [newProduct, ..._products];
      _status = ProductStatus.loaded;
      notifyListeners();
      return true;
    } on ApiException catch (e) {
      _errorMessage = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      _errorMessage = 'Failed to create product: $e';
      notifyListeners();
      return false;
    }
  }
}
