import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/product_model.dart';

/// Contract for remote product data source operations.
abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();

  Future<ProductModel> createProduct({
    required String title,
    required double price,
    String? description,
    String? imageUrl,
  });
}

/// Concrete implementation of [ProductRemoteDataSource] communicating via [ApiClient].
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final ApiClient _apiClient;

  ProductRemoteDataSourceImpl({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _apiClient.get(ApiConstants.productsEndpoint);

    if (response is Map<String, dynamic> && response.containsKey('data')) {
      final list = response['data'] as List<dynamic>;
      return list
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } else if (response is List) {
      return response
          .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  @override
  Future<ProductModel> createProduct({
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
      return ProductModel.fromJson(productData as Map<String, dynamic>);
    }

    throw const ApiException('Invalid response format received from server.');
  }
}
