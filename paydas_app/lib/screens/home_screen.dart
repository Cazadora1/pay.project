import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../models/post.dart';
import 'create_post_screen.dart';
import 'profile_screen.dart';
import '../widgets/post_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Post> _posts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading posts
    await Future.delayed(const Duration(seconds: 1));

    // Add some sample posts
    final samplePosts = [
      Post(
        id: '1',
        title: 'Eski Bilgisayar',
        description: 'Çalışır durumda eski bilgisayar, ücretsiz veriyorum.',
        category: 'Eşya',
        authorEmail: 'user1@example.com',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Post(
        id: '2',
        title: 'Taze Ekmek',
        description: 'Fırından yeni çıkmış ekmek, paylaşmak istiyorum.',
        category: 'Gıda',
        authorEmail: 'user2@example.com',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Post(
        id: '3',
        title: 'Kitap Koleksiyonu',
        description: 'Roman ve bilim kurgu kitapları, okuyacak birini arıyorum.',
        category: 'Diğer',
        authorEmail: 'user3@example.com',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];

    setState(() {
      _posts.clear();
      _posts.addAll(samplePosts);
      _isLoading = false;
    });
  }

  Future<void> _refreshPosts() async {
    await _loadPosts();
  }

  void _logout() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İlanlar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
            tooltip: 'Profile',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPosts,
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _posts.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Henüz ilan yok',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'İlk ilanı sen oluştur!',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      return PostCard(post: _posts[index]);
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreatePostScreen(),
            ),
          );
          
          if (result == true) {
            _refreshPosts();
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('İlan başarıyla oluşturuldu!'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            }
          }
        },
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}