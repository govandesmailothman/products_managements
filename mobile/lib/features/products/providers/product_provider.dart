import 'package:flutter/foundation.dart';

import '../../../core/network/api_client.dart';
import '../models/product_model.dart';
import '../repositories/product_repository.dart';

enum ProductStatus { initial, loading, loaded, error }

class ProductProvider extends ChangeNotifier {
  final ProductRepository _repository;

  ProductProvider({ProductRepository? repository})
    : _repository = repository ?? ProductRepository();

  List<Product> _products = [];
  ProductStatus _status = ProductStatus.initial;
  String? _errorMessage;

  List<Product> get products => List.unmodifiable(_products);
  ProductStatus get status => _status;
  String? get errorMessage => _errorMessage;

  bool get isLoading => _status == ProductStatus.loading;
  bool get hasError => _status == ProductStatus.error;
  bool get isEmpty => _status == ProductStatus.loaded && _products.isEmpty;

  /// Fetches products from the repository and updates UI state.
  Future<void> fetchProducts() async {
    _status = ProductStatus.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final fetchedProducts = await _repository.getProducts();
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

  /// Adds a new product and inserts it at the beginning of the list.
  Future<bool> addProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  }) async {
    try {
      final newProduct = await _repository.createProduct(
        title: title,
        price: price,
        description: description,
        imageUrl: imageUrl,
      );

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
