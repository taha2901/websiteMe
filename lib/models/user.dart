class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? avatar;
  final List<String> addresses;
  final bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.avatar,
    this.addresses = const [],
    this.isAdmin = false,
  });
}