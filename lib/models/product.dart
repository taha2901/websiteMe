class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String image;
  final List<String> images;
  final String category;
  final int stock;
  final double rating;
  final int reviewsCount;
  final List<String> features;
  final Map<String, dynamic>? specifications;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.image,
    required this.images,
    required this.category,
    required this.stock,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.features = const [],
    this.specifications,
  });

  bool get isOnSale => discountPrice != null && discountPrice! < price;
  double get finalPrice => discountPrice ?? price;
  int get discountPercentage => 
      isOnSale ? ((1 - finalPrice / price) * 100).round() : 0;
}



final List<Product> demoProducts = [
  Product(
    id: 'p1',
    name: 'Wireless Headphones',
    description: 'High-quality over-ear Bluetooth headphones with noise cancellation.',
    price: 120.0,
    discountPrice: 89.99,
    image: 'https://picsum.photos/400/400?1',
    images: [
      'https://picsum.photos/400/400?1',
      'https://picsum.photos/400/400?2',
      'https://picsum.photos/400/400?3',
    ],
    category: 'Electronics',
    stock: 15,
    rating: 4.6,
    reviewsCount: 340,
    features: [
      'Bluetooth 5.0',
      'Noise Cancellation',
      '20 Hours Battery',
      'Foldable Design',
    ],
    specifications: {
      'Weight': '250g',
      'Color': 'Black',
      'Charging Port': 'USB-C',
      'Warranty': '1 Year',
    },
  ),
  Product(
    id: 'p2',
    name: 'Smart Watch Pro X',
    description: 'Waterproof smartwatch with health tracking and notifications.',
    price: 150.0,
    discountPrice: 119.99,
    image: 'https://picsum.photos/400/400?4',
    images: [
      'https://picsum.photos/400/400?4',
      'https://picsum.photos/400/400?5',
    ],
    category: 'Wearables',
    stock: 30,
    rating: 4.3,
    reviewsCount: 120,
    features: ['Heart Rate Monitor', 'Sleep Tracker', 'Notifications', 'Waterproof'],
    specifications: {'Battery Life': '48h', 'Color': 'Silver', 'Compatibility': 'iOS/Android'},
  ),
  Product(
    id: 'p1',
    name: 'Wireless Headphones',
    description: 'High-quality over-ear Bluetooth headphones with noise cancellation.',
    price: 120.0,
    discountPrice: 89.99,
    image: 'https://picsum.photos/400/400?1',
    images: [
      'https://picsum.photos/400/400?1',
      'https://picsum.photos/400/400?2',
      'https://picsum.photos/400/400?3',
    ],
    category: 'Electronics',
    stock: 15,
    rating: 4.6,
    reviewsCount: 340,
    features: [
      'Bluetooth 5.0',
      'Noise Cancellation',
      '20 Hours Battery',
      'Foldable Design',
    ],
    specifications: {
      'Weight': '250g',
      'Color': 'Black',
      'Charging Port': 'USB-C',
      'Warranty': '1 Year',
    },
  ),
  Product(
    id: 'p2',
    name: 'Smart Watch Pro X',
    description: 'Waterproof smartwatch with health tracking and notifications.',
    price: 150.0,
    discountPrice: 119.99,
    image: 'https://picsum.photos/400/400?4',
    images: [
      'https://picsum.photos/400/400?4',
      'https://picsum.photos/400/400?5',
    ],
    category: 'Wearables',
    stock: 30,
    rating: 4.3,
    reviewsCount: 120,
    features: ['Heart Rate Monitor', 'Sleep Tracker', 'Notifications', 'Waterproof'],
    specifications: {'Battery Life': '48h', 'Color': 'Silver', 'Compatibility': 'iOS/Android'},
  ),
  Product(
    id: 'p1',
    name: 'Wireless Headphones',
    description: 'High-quality over-ear Bluetooth headphones with noise cancellation.',
    price: 120.0,
    discountPrice: 89.99,
    image: 'https://picsum.photos/400/400?1',
    images: [
      'https://picsum.photos/400/400?1',
      'https://picsum.photos/400/400?2',
      'https://picsum.photos/400/400?3',
    ],
    category: 'Electronics',
    stock: 15,
    rating: 4.6,
    reviewsCount: 340,
    features: [
      'Bluetooth 5.0',
      'Noise Cancellation',
      '20 Hours Battery',
      'Foldable Design',
    ],
    specifications: {
      'Weight': '250g',
      'Color': 'Black',
      'Charging Port': 'USB-C',
      'Warranty': '1 Year',
    },
  ),
  Product(
    id: 'p2',
    name: 'Smart Watch Pro X',
    description: 'Waterproof smartwatch with health tracking and notifications.',
    price: 150.0,
    discountPrice: 119.99,
    image: 'https://picsum.photos/400/400?4',
    images: [
      'https://picsum.photos/400/400?4',
      'https://picsum.photos/400/400?5',
    ],
    category: 'Wearables',
    stock: 30,
    rating: 4.3,
    reviewsCount: 120,
    features: ['Heart Rate Monitor', 'Sleep Tracker', 'Notifications', 'Waterproof'],
    specifications: {'Battery Life': '48h', 'Color': 'Silver', 'Compatibility': 'iOS/Android'},
  ),
  Product(
    id: 'p3',
    name: 'DSLR Camera Mark IV',
    description: 'Professional DSLR camera with 4K video recording and 24MP sensor.',
    price: 999.0,
    discountPrice: null,
    image: 'https://picsum.photos/400/400?6',
    images: [
      'https://picsum.photos/400/400?6',
      'https://picsum.photos/400/400?7',
    ],
    category: 'Cameras',
    stock: 5,
    rating: 4.8,
    reviewsCount: 210,
    features: ['24MP Sensor', '4K Video', 'Wi-Fi', 'Interchangeable Lens'],
    specifications: {'Sensor': 'Full Frame', 'ISO Range': '100–25600', 'Weight': '890g'},
  ),
  Product(
    id: 'p4',
    name: 'Gaming Mouse RGB',
    description: 'Ergonomic gaming mouse with adjustable DPI and RGB lighting.',
    price: 49.99,
    discountPrice: 39.99,
    image: 'https://picsum.photos/400/400?8',
    images: [
      'https://picsum.photos/400/400?8',
      'https://picsum.photos/400/400?9',
    ],
    category: 'Accessories',
    stock: 60,
    rating: 4.5,
    reviewsCount: 540,
    features: ['RGB Lighting', 'Adjustable DPI', 'Ergonomic Design'],
    specifications: {'DPI': '16000', 'Buttons': '8', 'Connection': 'Wired'},
  ),
];
