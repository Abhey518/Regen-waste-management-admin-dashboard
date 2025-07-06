import 'package:flutter/material.dart';

class ArticlesSection extends StatefulWidget {
  const ArticlesSection({super.key});

  @override
  State<ArticlesSection> createState() => _ArticlesSectionState();
}

class _ArticlesSectionState extends State<ArticlesSection> {
  List<Article> _articles = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedCategoryFilter = 'All';

  // Mock categories - you can expand this list
  final List<String> _categories = [
    'Environment',
    'Climate Change',
    'Renewable Energy',
    'Conservation',
    'Sustainability',
    'Wildlife',
    'Pollution',
    'Green Technology',
  ];

  @override
  void initState() {
    super.initState();
    _loadMockArticles();
  }

  void _loadMockArticles() {
    // Mock data for demonstration
    setState(() {
      _articles = [
        Article(
          id: '1',
          title: 'Climate Change and Its Impact on Wildlife',
          imageUrl: 'https://via.placeholder.com/400x200',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
          category: 'Climate Change',
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        Article(
          id: '2',
          title: 'Renewable Energy Solutions for the Future',
          imageUrl: 'https://via.placeholder.com/400x200',
          content:
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...',
          category: 'Renewable Energy',
          createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ];
    });
  }

  List<Article> get _filteredArticles {
    return _articles.where((article) {
      final matchesSearch =
          article.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          article.content.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategoryFilter == 'All' ||
          article.category == _selectedCategoryFilter;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  void _showCreateArticleDialog() {
    showDialog(
      context: context,
      builder: (context) => _CreateEditArticleDialog(
        categories: _categories,
        onSave: (article) {
          setState(() {
            _articles.add(article);
          });
        },
      ),
    );
  }

  void _showEditArticleDialog(Article article) {
    showDialog(
      context: context,
      builder: (context) => _CreateEditArticleDialog(
        article: article,
        categories: _categories,
        onSave: (updatedArticle) {
          setState(() {
            final index = _articles.indexWhere(
              (a) => a.id == updatedArticle.id,
            );
            if (index != -1) {
              _articles[index] = updatedArticle;
            }
          });
        },
      ),
    );
  }

  void _deleteArticle(String articleId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Article'),
        content: const Text('Are you sure you want to delete this article?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _articles.removeWhere((article) => article.id == articleId);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Article deleted successfully')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
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
                'Articles Management',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                onPressed: _showCreateArticleDialog,
                icon: const Icon(Icons.add),
                label: const Text('Create Article'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF86C13C),
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Search and Filter Bar
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search articles...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  value: _selectedCategoryFilter,
                  decoration: const InputDecoration(
                    labelText: 'Filter by Category',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All', ..._categories].map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategoryFilter = value!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Articles List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredArticles.isEmpty
                ? const Center(
                    child: Text(
                      'No articles found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredArticles.length,
                    itemBuilder: (context, index) {
                      final article = _filteredArticles[index];
                      return _buildArticleCard(article);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildArticleCard(Article article) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Article Image
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  article.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Article Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          article.category,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        article.formattedDate,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Column(
              children: [
                IconButton(
                  onPressed: () => _showEditArticleDialog(article),
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  tooltip: 'Edit Article',
                ),
                IconButton(
                  onPressed: () => _deleteArticle(article.id),
                  icon: const Icon(Icons.delete, color: Colors.red),
                  tooltip: 'Delete Article',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CreateEditArticleDialog extends StatefulWidget {
  final Article? article;
  final List<String> categories;
  final Function(Article) onSave;

  const _CreateEditArticleDialog({
    this.article,
    required this.categories,
    required this.onSave,
  });

  @override
  State<_CreateEditArticleDialog> createState() =>
      _CreateEditArticleDialogState();
}

class _CreateEditArticleDialogState extends State<_CreateEditArticleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    if (widget.article != null) {
      _titleController.text = widget.article!.title;
      _contentController.text = widget.article!.content;
      _imageUrlController.text = widget.article!.imageUrl;
      _selectedCategory = widget.article!.category;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveArticle() {
    if (_formKey.currentState!.validate() && _selectedCategory != null) {
      final article = Article(
        id:
            widget.article?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        content: _contentController.text,
        imageUrl: _imageUrlController.text,
        category: _selectedCategory!,
        createdAt: widget.article?.createdAt ?? DateTime.now(),
      );
      widget.onSave(article);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 600,
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.article == null ? 'Create Article' : 'Edit Article',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              // Title Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.title, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Text(
                        'Article Title *',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter the article title...',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a title';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Category Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.category, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Text(
                        'Category *',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedCategory,
                    decoration: const InputDecoration(
                      hintText: 'Select article category...',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.categories.map((category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a category';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Image URL Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.image, size: 20, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Text(
                        'Image URL *',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _imageUrlController,
                    decoration: const InputDecoration(
                      hintText:
                          'Enter image URL (e.g., https://example.com/image.jpg)',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter an image URL';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Content Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.description,
                        size: 20,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Article Content *',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _contentController,
                    decoration: const InputDecoration(
                      hintText: 'Write the full article content here...',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 5,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter article content';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _saveArticle,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF86C13C),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(widget.article == null ? 'Create' : 'Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Article {
  final String id;
  final String title;
  final String imageUrl;
  final String content;
  final String category;
  final DateTime createdAt;

  Article({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.category,
    required this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }
}
