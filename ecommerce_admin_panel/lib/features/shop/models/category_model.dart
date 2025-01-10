class CategoryModel {
  String id;
  String name;
  String image;

  // Constructor
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });

  // Factory method to create a CategoryModel from JSON
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // Method to convert CategoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
