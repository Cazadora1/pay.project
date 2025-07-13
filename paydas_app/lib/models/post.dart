class Post {
  final String id;
  final String title;
  final String description;
  final String category;
  final String authorEmail;
  final String? imageUrl;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.authorEmail,
    this.imageUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'authorEmail': authorEmail,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      authorEmail: map['authorEmail'] ?? '',
      imageUrl: map['imageUrl'],
      createdAt: DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}