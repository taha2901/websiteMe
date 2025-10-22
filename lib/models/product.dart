class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? discountPrice;
  final String image;
  final List<String> images;
  final double? oldPrice;
  final String category;
  final int stock;
  final double rating;
  final int reviewsCount;
  final List<String> features;
  final Map<String, String>? specifications;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.image,
    required this.images,
    this.oldPrice,
    required this.category,
    required this.stock,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.features = const [],
    this.specifications,
  });

  // ✅ تحويل الداتا إلى Map لحفظها في Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'discountPrice': discountPrice,
      'oldPrice': oldPrice,
      'image': image,
      'images': images,
      'category': category,
      'stock': stock,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'features': features,
      'specifications': specifications,
    };
  }

  // ✅ إنشاء كائن Product من Map (Firestore)
  factory Product.fromMap(Map<String, dynamic> data, String documentId) {
    return Product(
      id: documentId,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      discountPrice: (data['discountPrice'] ?? 0).toDouble(),
      image: data['image'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      oldPrice: (data['oldPrice'] ?? 0).toDouble(),
      category: data['category'] ?? '',
      stock: data['stock'] ?? 0,
      rating: (data['rating'] ?? 0).toDouble(),
      reviewsCount: data['reviewsCount'] ?? 0,
      features: List<String>.from(data['features'] ?? []),
      specifications: Map<String, String>.from(data['specifications'] ?? {}),
    );
  }

  bool get isOnSale => discountPrice != null && discountPrice! < price;
  double get finalPrice => discountPrice ?? price;
  int get discountPercentage =>
      isOnSale ? ((1 - finalPrice / price) * 100).round() : 0;
}

final List<Product> demoProducts = [
  Product(
    id: 'p1',
    name: 'Wireless Headphones',
    description:
        'High-quality over-ear Bluetooth headphones with noise cancellation.',
    price: 120.0,
    discountPrice: 89.99,
    oldPrice: 150.0,
    image: 'https://picsum.photos/400/400?1',
    images: [
      'https://picsum.photos/400/400?1',
      'https://picsum.photos/400/400?2',
    ],
    category: 'Electronics',
    stock: 20,
    rating: 4.6,
    reviewsCount: 340,
    features: ['Bluetooth 5.0', 'Noise Cancellation', '20h Battery'],
    specifications: {
      'Color': 'Black',
      'Weight': '250g',
      'Charging': 'USB-C',
    },
  ),
  Product(
    id: 'p2',
    name: 'Smart Watch Pro X',
    description: 'Waterproof smartwatch with fitness tracking and GPS.',
    price: 200.0,
    discountPrice: 149.99,
    oldPrice: 220.0,
    image: 'https://picsum.photos/400/400?4',
    images: [
      'https://picsum.photos/400/400?4',
      'https://picsum.photos/400/400?5',
    ],
    category: 'Wearables',
    stock: 30,
    rating: 4.3,
    reviewsCount: 120,
    features: [
      'Heart Rate Monitor',
      'Sleep Tracker',
      'Notifications',
      'Waterproof'
    ],
    specifications: {
      'Battery Life': '48h',
      'Compatibility': 'iOS/Android',
    },
  ),
  Product(
    id: 'p3',
    name: 'DSLR Camera Mark IV',
    description:
        'Professional DSLR camera with 4K video recording and 24MP sensor.',
    price: 999.0,
    oldPrice: 1099.0,
    discountPrice: 899.0,
    image: 'https://picsum.photos/400/400?6',
    images: [
      'https://picsum.photos/400/400?6',
      'https://picsum.photos/400/400?7',
    ],
    category: 'Cameras',
    stock: 10,
    rating: 4.8,
    reviewsCount: 210,
    features: ['24MP Sensor', '4K Video', 'Wi-Fi'],
    specifications: {
      'Sensor': 'Full Frame',
      'ISO Range': '100–25600',
      'Weight': '890g',
    },
  ),
  Product(
    id: 'p4',
    name: 'Gaming Mouse RGB',
    description: 'Ergonomic gaming mouse with adjustable DPI and RGB lighting.',
    price: 60.0,
    oldPrice: 75.0,
    discountPrice: 49.99,
    image: 'https://picsum.photos/400/400?8',
    images: [
      'https://picsum.photos/400/400?8',
      'https://picsum.photos/400/400?9',
    ],
    category: 'Accessories',
    stock: 80,
    rating: 4.5,
    reviewsCount: 540,
    features: ['RGB Lighting', 'Adjustable DPI', 'Ergonomic Design'],
    specifications: {'DPI': '16000', 'Buttons': '8', 'Connection': 'Wired'},
  ),
  Product(
    id: 'p5',
    name: 'Bluetooth Speaker Mini',
    description:
        'Compact portable speaker with deep bass and 10-hour battery life.',
    price: 89.0,
    oldPrice: 120.0,
    discountPrice: 79.99,
    image: 'https://picsum.photos/400/400?10',
    images: [
      'https://picsum.photos/400/400?10',
      'https://picsum.photos/400/400?11',
    ],
    category: 'Electronics',
    stock: 50,
    rating: 4.4,
    reviewsCount: 270,
    features: ['Bluetooth 5.1', 'Water Resistant', 'Portable'],
    specifications: {'Battery': '10h', 'Color': 'Blue', 'Power': '15W'},
  ),
  Product(
    id: 'p6',
    name: 'Wireless Charger Pad',
    description:
        'Fast wireless charger compatible with all Qi-enabled smartphones.',
    price: 39.99,
    oldPrice: 50.0,
    discountPrice: 34.99,
    image: 'https://picsum.photos/400/400?12',
    images: [
      'https://picsum.photos/400/400?12',
      'https://picsum.photos/400/400?13',
    ],
    category: 'Accessories',
    stock: 100,
    rating: 4.2,
    reviewsCount: 410,
    features: ['Fast Charging', 'LED Indicator', 'Slip Resistant'],
    specifications: {
      'Output': '15W',
      'Connector': 'USB-C',
      'Material': 'Aluminum'
    },
  ),
  Product(
    id: 'p7',
    name: 'Smart Fitness Band 3',
    description: 'Slim fitness tracker with step counter and heart monitor.',
    price: 79.99,
    oldPrice: 99.0,
    discountPrice: 69.99,
    image: 'https://picsum.photos/400/400?14',
    images: [
      'https://picsum.photos/400/400?14',
      'https://picsum.photos/400/400?15',
    ],
    category: 'Wearables',
    stock: 40,
    rating: 4.1,
    reviewsCount: 190,
    features: ['Step Counter', 'Heart Rate', 'Sleep Tracking'],
    specifications: {'Battery': '7 Days', 'Waterproof': 'Yes'},
  ),
  Product(
    id: 'p8',
    name: '4K Action Camera',
    description:
        'Compact waterproof action camera ideal for sports and adventure.',
    price: 250.0,
    oldPrice: 300.0,
    discountPrice: 229.99,
    image: 'https://picsum.photos/400/400?16',
    images: [
      'https://picsum.photos/400/400?16',
      'https://picsum.photos/400/400?17',
    ],
    category: 'Cameras',
    stock: 25,
    rating: 4.7,
    reviewsCount: 320,
    features: ['4K Recording', 'Waterproof', 'Wi-Fi Control'],
    specifications: {
      'Resolution': '4K',
      'Battery': '2h',
      'Waterproof': '30m Depth'
    },
  ),
];
