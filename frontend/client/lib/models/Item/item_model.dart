class ItemCategoryModel {
  final String id;
  final String name;
  final ItemCategoryModel? parent;
  final List<ItemCategoryModel> children;

  ItemCategoryModel({
    required this.id,
    required this.name,
    this.parent,
    this.children = const [],
  });
}

class ItemModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String location;
  final String updatedAt;
  final String status;
  final ItemCategoryModel category;

  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.location,
    required this.updatedAt,
    required this.status,
    required this.category,
  });
}
