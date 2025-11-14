class ProductoModel {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;
  final String category;

  ProductoModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
  });

  factory ProductoModel.fromJson(Map<String, dynamic> json) {
    String categoryName;
    if (json['category'] is String) {
      categoryName = json['category'];
    } else if (json['category'] is Map && json['category']['name'] != null) {
      categoryName = json['category']['name'];
    } else {
      categoryName = '';
    }
    
    return ProductoModel(
      id: json['id'],
      title: json['title'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : [],
      category: categoryName,
    );
  }
}
