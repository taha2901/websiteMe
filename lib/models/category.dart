class CategoryModel {
  final String id;
  final String name;
  final String icon;
  final String image;
  final int productsCount;

  CategoryModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.image,
    required this.productsCount,
  });
}


final List<CategoryModel> demoCategories = [
  CategoryModel(
    id: 'c1',
    name: 'Electronics',
    icon: '💻',
    image: 'https://picsum.photos/600/400?10',
    productsCount: 58,
  ),
  CategoryModel(
    id: 'c2',
    name: 'Wearables',
    icon: '⌚',
    image: 'https://picsum.photos/600/400?11',
    productsCount: 34,
  ),
  CategoryModel(
    id: 'c3',
    name: 'Cameras',
    icon: '📸',
    image: 'https://picsum.photos/600/400?12',
    productsCount: 20,
  ),
  CategoryModel(
    id: 'c4',
    name: 'Accessories',
    icon: '🎮',
    image: 'https://picsum.photos/600/400?13',
    productsCount: 72,
  ),
  CategoryModel(
    id: 'c1',
    name: 'Electronics',
    icon: '💻',
    image: 'https://picsum.photos/600/400?10',
    productsCount: 58,
  ),
  CategoryModel(
    id: 'c2',
    name: 'Wearables',
    icon: '⌚',
    image: 'https://picsum.photos/600/400?11',
    productsCount: 34,
  ),
  CategoryModel(
    id: 'c3',
    name: 'Cameras',
    icon: '📸',
    image: 'https://picsum.photos/600/400?12',
    productsCount: 20,
  ),
  CategoryModel(
    id: 'c4',
    name: 'Accessories',
    icon: '🎮',
    image: 'https://picsum.photos/600/400?13',
    productsCount: 72,
  ),
];
