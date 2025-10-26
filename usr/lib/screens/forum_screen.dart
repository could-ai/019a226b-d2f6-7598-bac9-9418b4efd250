import 'package:flutter/material.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Health Community Forum')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildForumPost('Managing Diabetes', 'Tips for blood sugar control...', 'Dr. Adebayo'),
          _buildForumPost('Mental Health Support', 'Dealing with anxiety...', 'Dr. Chioma'),
          _buildForumPost('Hypertension Management', 'Lifestyle changes...', 'Pharm. Okwu'),
          // Add more posts
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewPostDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildForumPost(String title, String content, String author) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(content),
            const SizedBox(height: 8),
            Text('By: $author', style: const TextStyle(color: Colors.grey)),
            Row(
              children: [
                IconButton(icon: const Icon(Icons.thumb_up), onPressed: () {}),
                IconButton(icon: const Icon(Icons.comment), onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showNewPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Post'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(decoration: InputDecoration(labelText: 'Title')),
            TextField(decoration: InputDecoration(labelText: 'Content'), maxLines: 3),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Post')),
        ],
      ),
    );
  }
}
