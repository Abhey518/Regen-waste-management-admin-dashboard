import 'package:flutter/material.dart';

class KidsSection extends StatefulWidget {
  const KidsSection({super.key});

  @override
  State<KidsSection> createState() => _KidsSectionState();
}

class _KidsSectionState extends State<KidsSection> {
  List<KidsPost> _posts = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All',
    'Environment',
    'Recycling',
    'Wildlife',
    'Energy',
    'Water',
    'Plants',
    'Climate',
  ];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    // Mock data for demonstration
    _posts = [
      KidsPost(
        id: '1',
        title: 'Why Recycling is Important',
        imageUrl: 'https://via.placeholder.com/300x200',
        content: 'Learn about recycling and how it helps our planet...',
        category: 'Recycling',
        quizQuestion: 'What color bin is used for recycling paper?',
        quizOptions: ['Red', 'Blue', 'Green', 'Yellow'],
        correctAnswerIndex: 1,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      KidsPost(
        id: '2',
        title: 'Save Water, Save Earth',
        imageUrl: 'https://via.placeholder.com/300x200',
        content: 'Discover fun ways to save water every day...',
        category: 'Water',
        quizQuestion:
            'How much water can you save by turning off the tap while brushing teeth?',
        quizOptions: ['1 liter', '5 liters', '10 liters', '20 liters'],
        correctAnswerIndex: 2,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      KidsPost(
        id: '3',
        title: 'Amazing Animals and Their Homes',
        imageUrl: 'https://via.placeholder.com/300x200',
        content: 'Explore different animal habitats and how to protect them...',
        category: 'Wildlife',
        quizQuestion: 'Where do polar bears live?',
        quizOptions: ['Desert', 'Forest', 'Arctic', 'Ocean'],
        correctAnswerIndex: 2,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }

  List<KidsPost> get _filteredPosts {
    return _posts.where((post) {
      final matchesSearch =
          post.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          post.content.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || post.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Kids Content Management',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showCreateEditDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Add New Post'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF86C13C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Filters and Search
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Search Field
                  Expanded(
                    flex: 2,
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Search posts...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Category Filter
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _categories.map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Stats Cards
          Row(
            children: [
              _buildStatCard(
                'Total Posts',
                _posts.length.toString(),
                Icons.article,
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'Categories',
                (_categories.length - 1).toString(),
                Icons.category,
                Colors.green,
              ),
              const SizedBox(width: 16),
              _buildStatCard('This Week', '2', Icons.schedule, Colors.orange),
            ],
          ),
          const SizedBox(height: 24),

          // Posts Table
          Expanded(
            child: Card(
              child: Column(
                children: [
                  // Table Header
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Title',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Category',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Created',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Text(
                            'Actions',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Table Content
                  Expanded(
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            itemCount: _filteredPosts.length,
                            itemBuilder: (context, index) {
                              final post = _filteredPosts[index];
                              return _buildPostRow(post, index);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostRow(KidsPost post, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          // Title with image
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: const Icon(Icons.image, color: Colors.grey),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        post.content,
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Category
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(post.category).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                post.category,
                style: TextStyle(
                  color: _getCategoryColor(post.category),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Created Date
          Expanded(
            child: Text(
              _formatDate(post.createdAt),
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),

          // Actions
          SizedBox(
            width: 120,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 18),
                  onPressed: () => _showPostDetails(post),
                  tooltip: 'View',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: () => _showCreateEditDialog(post: post),
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                  onPressed: () => _showDeleteConfirmation(post),
                  tooltip: 'Delete',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Environment':
        return Colors.green;
      case 'Recycling':
        return Colors.blue;
      case 'Wildlife':
        return Colors.orange;
      case 'Energy':
        return Colors.yellow.shade700;
      case 'Water':
        return Colors.cyan;
      case 'Plants':
        return Colors.lightGreen;
      case 'Climate':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showCreateEditDialog({KidsPost? post}) {
    showDialog(
      context: context,
      builder: (context) => CreateEditKidsPostDialog(
        post: post,
        categories: _categories.where((c) => c != 'All').toList(),
        onSave: (newPost) {
          setState(() {
            if (post != null) {
              final index = _posts.indexWhere((p) => p.id == post.id);
              if (index != -1) {
                _posts[index] = newPost;
              }
            } else {
              _posts.insert(0, newPost);
            }
          });
        },
      ),
    );
  }

  void _showPostDetails(KidsPost post) {
    showDialog(
      context: context,
      builder: (context) => PostDetailsDialog(post: post),
    );
  }

  void _showDeleteConfirmation(KidsPost post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: Text('Are you sure you want to delete "${post.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _posts.removeWhere((p) => p.id == post.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Post deleted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// Create/Edit Dialog
class CreateEditKidsPostDialog extends StatefulWidget {
  final KidsPost? post;
  final List<String> categories;
  final Function(KidsPost) onSave;

  const CreateEditKidsPostDialog({
    super.key,
    this.post,
    required this.categories,
    required this.onSave,
  });

  @override
  State<CreateEditKidsPostDialog> createState() =>
      _CreateEditKidsPostDialogState();
}

class _CreateEditKidsPostDialogState extends State<CreateEditKidsPostDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late TextEditingController _imageUrlController;
  late TextEditingController _quizQuestionController;
  late List<TextEditingController> _optionControllers;
  late String _selectedCategory;
  int _correctAnswerIndex = 0;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post?.title ?? '');
    _contentController = TextEditingController(
      text: widget.post?.content ?? '',
    );
    _imageUrlController = TextEditingController(
      text: widget.post?.imageUrl ?? '',
    );
    _quizQuestionController = TextEditingController(
      text: widget.post?.quizQuestion ?? '',
    );
    _selectedCategory = widget.post?.category ?? widget.categories.first;
    _correctAnswerIndex = widget.post?.correctAnswerIndex ?? 0;

    _optionControllers = List.generate(4, (index) {
      final options = widget.post?.quizOptions ?? ['', '', '', ''];
      return TextEditingController(
        text: index < options.length ? options[index] : '',
      );
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _imageUrlController.dispose();
    _quizQuestionController.dispose();
    for (var controller in _optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 600,
        height: 700,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post != null ? 'Edit Kids Post' : 'Create New Kids Post',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Title
                      TextFormField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value?.isEmpty ?? true ? 'Title is required' : null,
                      ),
                      const SizedBox(height: 16),

                      // Category
                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: widget.categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _selectedCategory = value!),
                      ),
                      const SizedBox(height: 16),

                      // Image URL
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: const InputDecoration(
                          labelText: 'Image URL',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Image URL is required'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Content
                      TextFormField(
                        controller: _contentController,
                        decoration: const InputDecoration(
                          labelText: 'Content',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Content is required'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Quiz Question
                      TextFormField(
                        controller: _quizQuestionController,
                        decoration: const InputDecoration(
                          labelText: 'Quiz Question',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Quiz question is required'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Quiz Options
                      const Text(
                        'Quiz Options:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ..._optionControllers.asMap().entries.map((entry) {
                        final index = entry.key;
                        final controller = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Radio<int>(
                                value: index,
                                groupValue: _correctAnswerIndex,
                                onChanged: (value) => setState(
                                  () => _correctAnswerIndex = value!,
                                ),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                    labelText: 'Option ${index + 1}',
                                    border: const OutlineInputBorder(),
                                  ),
                                  validator: (value) => value?.isEmpty ?? true
                                      ? 'Option ${index + 1} is required'
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _savePost,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF86C13C),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(widget.post != null ? 'Update' : 'Create'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _savePost() {
    if (_formKey.currentState!.validate()) {
      final post = KidsPost(
        id: widget.post?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        content: _contentController.text,
        imageUrl: _imageUrlController.text,
        category: _selectedCategory,
        quizQuestion: _quizQuestionController.text,
        quizOptions: _optionControllers.map((c) => c.text).toList(),
        correctAnswerIndex: _correctAnswerIndex,
        createdAt: widget.post?.createdAt ?? DateTime.now(),
      );

      widget.onSave(post);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.post != null
                ? 'Post updated successfully'
                : 'Post created successfully',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}

// Post Details Dialog
class PostDetailsDialog extends StatelessWidget {
  final KidsPost post;

  const PostDetailsDialog({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 500,
        height: 600,
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Post Details',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    Container(
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[300],
                      ),
                      child: const Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Text(
                      post.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Category
                    Chip(
                      label: Text(post.category),
                      backgroundColor: Colors.green.withValues(alpha: 0.1),
                    ),
                    const SizedBox(height: 16),

                    // Content
                    const Text(
                      'Content:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(post.content),
                    const SizedBox(height: 16),

                    // Quiz
                    const Text(
                      'Quiz:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('Question: ${post.quizQuestion}'),
                    const SizedBox(height: 8),
                    ...post.quizOptions.asMap().entries.map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      final isCorrect = index == post.correctAnswerIndex;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Icon(
                              isCorrect
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: isCorrect ? Colors.green : Colors.grey,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              option,
                              style: TextStyle(
                                color: isCorrect ? Colors.green : Colors.black,
                                fontWeight: isCorrect
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 16),

                    // Created Date
                    Text(
                      'Created: ${post.createdAt.day}/${post.createdAt.month}/${post.createdAt.year}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// KidsPost Model
class KidsPost {
  final String id;
  final String title;
  final String imageUrl;
  final String content;
  final String category;
  final String quizQuestion;
  final List<String> quizOptions;
  final int correctAnswerIndex;
  final DateTime createdAt;

  KidsPost({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.category,
    required this.quizQuestion,
    required this.quizOptions,
    required this.correctAnswerIndex,
    required this.createdAt,
  });
}
