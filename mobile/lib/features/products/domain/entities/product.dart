/// Pure Domain Entity representing a Product.
/// Independent of any network layer, data source, or framework libraries.
class Product {
  final int id;
  final String title;
  final String? description;
  final double price;
  final String? imageUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Product({
    required this.id,
    required this.title,
    this.description,
    required this.price,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Product &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          price == other.price &&
          imageUrl == other.imageUrl;

  @override
  int get hashCode =>
      id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      price.hashCode ^
      imageUrl.hashCode;

  @override
  String toString() {
    return 'Product(id: $id, title: $title, price: $price, imageUrl: $imageUrl)';
  }
}
