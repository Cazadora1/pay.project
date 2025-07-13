import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../models/post.dart';
import '../widgets/post_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Post> _userPosts = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserPosts();
  }

  Future<void> _loadUserPosts() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading user posts
    await Future.delayed(const Duration(seconds: 1));

    final authService = Provider.of<AuthService>(context, listen: false);
    final userEmail = authService.userEmail;

    // Add sample user posts
    final sampleUserPosts = [
      Post(
        id: '1',
        title: 'Eski Masa',
        description: 'Kullanmadığım eski masa, ihtiyacı olan birine verebilirim.',
        category: 'Eşya',
        authorEmail: userEmail ?? 'user@example.com',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Post(
        id: '2',
        title: 'Fazla Ekmek',
        description: 'Bugün fazla ekmek aldım, paylaşmak istiyorum.',
        category: 'Gıda',
        authorEmail: userEmail ?? 'user@example.com',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
      ),
    ];

    setState(() {
      _userPosts.clear();
      _userPosts.addAll(sampleUserPosts);
      _isLoading = false;
    });
  }

  void _logout() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final userEmail = authService.userEmail;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadUserPosts,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // User Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: const Color(0xFF4CAF50),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Kullanıcı',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      userEmail ?? 'unknown@example.com',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem('İlanlar', _userPosts.length.toString()),
                        _buildStatItem('Kategori', '3'),
                        _buildStatItem('Gün', '7'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // User Posts Section
            Row(
              children: [
                Icon(
                  Icons.article_outlined,
                  color: const Color(0xFF4CAF50),
                ),
                const SizedBox(width: 8),
                Text(
                  'İlanlarım',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Posts List
            if (_isLoading)
              const Center(
                child: CircularProgressIndicator(),
              )
            else if (_userPosts.isEmpty)
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Henüz ilan oluşturmadınız',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'İlk ilanınızı oluşturmak için + butonuna tıklayın',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[500],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ...(_userPosts.map((post) => PostCard(post: post)).toList()),

            const SizedBox(height: 32),

            // Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _logout,
                icon: const Icon(Icons.logout),
                label: const Text('Çıkış Yap'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: const Color(0xFF4CAF50),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}