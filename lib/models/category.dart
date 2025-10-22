class CategoryModel {
  final String id;
  final String name;
  final String image;
  final int productsCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.productsCount,
  });


  factory CategoryModel.fromMap(Map<String, dynamic> data, String documentId) {
  return CategoryModel(
    id: documentId,
    name: data['name'] ?? '',
    image: data['image'] ?? '',
    productsCount: data['productsCount'] ?? 0,
  );
}

}

final List<CategoryModel> demoCategories = [
  CategoryModel(
    id: 'cat1',
    name: 'Electronics',
    image: 'https://picsum.photos/600/400?1',
    productsCount: 58,
  ),
  CategoryModel(
    id: 'cat2',
    name: 'Wearables',
    image: 'https://picsum.photos/600/400?2',
    productsCount: 34,
  ),
  CategoryModel(
    id: 'cat3',
    name: 'Cameras',
    image: 'https://picsum.photos/600/400?3',
    productsCount: 20,
  ),
  CategoryModel(
    id: 'cat4',
    name: 'Accessories',
    image: 'https://picsum.photos/600/400?4',
    productsCount: 72,
  ),
  CategoryModel(
    id: 'cat5',
    name: 'Home Appliances',
    image: 'https://picsum.photos/600/400?5',
    productsCount: 43,
  ),
  CategoryModel(
    id: 'cat6',
    name: 'Beauty & Personal Care',
    image: 'https://picsum.photos/600/400?6',
    productsCount: 65,
  ),
  CategoryModel(
    id: 'cat7',
    name: 'Sports & Outdoors',
    image: 'https://picsum.photos/600/400?7',
    productsCount: 27,
  ),
  CategoryModel(
    id: 'cat8',
    name: 'Books & Stationery',
    image: 'https://picsum.photos/600/400?8',
    productsCount: 91,
  ),
  CategoryModel(
    id: 'cat9',
    name: 'Gaming',
    image: 'https://picsum.photos/600/400?9',
    productsCount: 38,
  ),
  CategoryModel(
    id: 'cat10',
    name: 'Groceries',
    image: 'https://picsum.photos/600/400?10',
    productsCount: 120,
  ),
];
