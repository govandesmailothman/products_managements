import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import '../models/product_model.dart';

/// Repository responsible for abstracting data access for Products.
class ProductRepository {
  final ApiClient _apiClient;

  ProductRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  /// Fetches the list of all products from the backend API.
  Future<List<Product>> getProducts() async {
    final response = await _apiClient.get(ApiConstants.productsEndpoint);

    if (response is Map<String, dynamic> && response.containsKey('data')) {
      final list = response['data'] as List<dynamic>;
      return list
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is List) {
      return response
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  /// Creates a new product on the backend API.
  Future<Product> createProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  }) async {
    final payload = {
      'title': title,
      'price': price,
      if (description != null && description.isNotEmpty)
        'description': description,
      if (imageUrl != null && imageUrl.isNotEmpty) 'image_url': imageUrl,
    };

    final response = await _apiClient.post(
      ApiConstants.productsEndpoint,
      payload,
    );

    if (response is Map<String, dynamic>) {
      final productData = response.containsKey('data')
          ? response['data']
          : response;
      return Product.fromJson(productData as Map<String, dynamic>);
    }

    throw const ApiException('Invalid response format received from server.');
  }
}
