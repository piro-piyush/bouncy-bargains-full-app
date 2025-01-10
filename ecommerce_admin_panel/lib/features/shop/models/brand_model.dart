class BrandModel {
  String id;
  String name;
  String image;

  // Constructor
  BrandModel({
    required this.id,
    required this.name,
    required this.image,
  });

  // Factory method to create a BrandModel from JSON
  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  // Method to convert BrandModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
