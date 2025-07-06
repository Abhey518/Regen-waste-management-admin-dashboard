import 'package:flutter/material.dart';

class UserFeedbackSection extends StatefulWidget {
  const UserFeedbackSection({super.key});

  @override
  State<UserFeedbackSection> createState() => _UserFeedbackSectionState();
}

class _UserFeedbackSectionState extends State<UserFeedbackSection> {
  List<UserFeedback> _feedbacks = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedCategory = 'All';
  String _selectedStatus = 'All';

  final List<String> _categories = [
    'All',
    'Bug Report',
    'Feature Request',
    'General',
    'Complaint',
    'Suggestion',
  ];
  final List<String> _statuses = [
    'All',
    'New',
    'In Review',
    'Resolved',
    'Closed',
  ];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    // Mock feedback data
    _feedbacks = [
      UserFeedback(
        id: '1',
        userName: 'John Doe',
        userEmail: 'john.doe@example.com',
        category: 'Feature Request',
        subject: 'Add Dark Mode',
        message:
            'It would be great to have a dark mode option for better user experience during night time.',
        status: 'In Review',
        priority: 'Medium',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        rating: 4,
      ),
      UserFeedback(
        id: '2',
        userName: 'Jane Smith',
        userEmail: 'jane.smith@example.com',
        category: 'Bug Report',
        subject: 'App crashes on login',
        message:
            'The app crashes every time I try to login with my Google account. Please fix this issue.',
        status: 'New',
        priority: 'High',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        rating: 2,
      ),
      UserFeedback(
        id: '3',
        userName: 'Mike Johnson',
        userEmail: 'mike.johnson@example.com',
        category: 'General',
        subject: 'Great app!',
        message:
            'I love using this app. It has helped me learn so much about environmental conservation.',
        status: 'Resolved',
        priority: 'Low',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        rating: 5,
      ),
      UserFeedback(
        id: '4',
        userName: 'Sarah Wilson',
        userEmail: 'sarah.wilson@example.com',
        category: 'Suggestion',
        subject: 'More quiz categories',
        message:
            'Please add more quiz categories like ocean conservation and renewable energy.',
        status: 'New',
        priority: 'Medium',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        rating: 4,
      ),
    ];
  }

  List<UserFeedback> get _filteredFeedbacks {
    return _feedbacks.where((feedback) {
      final matchesSearch =
          feedback.subject.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          feedback.userName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          feedback.message.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || feedback.category == _selectedCategory;
      final matchesStatus =
          _selectedStatus == 'All' || feedback.status == _selectedStatus;
      return matchesSearch && matchesCategory && matchesStatus;
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
          const Text(
            'User Feedback Management',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 24),

          // Filters and Search
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Search Field
                      Expanded(
                        flex: 2,
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Search feedback...',
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
                          onChanged: (value) =>
                              setState(() => _selectedCategory = value!),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Status Filter
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedStatus,
                          decoration: InputDecoration(
                            labelText: 'Status',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: _statuses.map((status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _selectedStatus = value!),
                        ),
                      ),
                    ],
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
                'Total Feedback',
                _feedbacks.length.toString(),
                Icons.feedback,
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'New',
                _feedbacks.where((f) => f.status == 'New').length.toString(),
                Icons.fiber_new,
                Colors.orange,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'In Review',
                _feedbacks
                    .where((f) => f.status == 'In Review')
                    .length
                    .toString(),
                Icons.rate_review,
                Colors.purple,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'Resolved',
                _feedbacks
                    .where((f) => f.status == 'Resolved')
                    .length
                    .toString(),
                Icons.check_circle,
                Colors.green,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Feedback Table
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
                            'User & Subject',
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
                            'Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Priority',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Rating',
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
                            itemCount: _filteredFeedbacks.length,
                            itemBuilder: (context, index) {
                              final feedback = _filteredFeedbacks[index];
                              return _buildFeedbackRow(feedback, index);
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

  Widget _buildFeedbackRow(UserFeedback feedback, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          // User & Subject
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedback.subject,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  feedback.userName,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),

          // Category
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getCategoryColor(
                  feedback.category,
                ).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                feedback.category,
                style: TextStyle(
                  color: _getCategoryColor(feedback.category),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Status
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(feedback.status).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                feedback.status,
                style: TextStyle(
                  color: _getStatusColor(feedback.status),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Priority
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getPriorityColor(
                  feedback.priority,
                ).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                feedback.priority,
                style: TextStyle(
                  color: _getPriorityColor(feedback.priority),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Rating
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (starIndex) {
                return Icon(
                  starIndex < feedback.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 16,
                );
              }),
            ),
          ),

          // Actions
          SizedBox(
            width: 120,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility, size: 18),
                  onPressed: () => _showFeedbackDetails(feedback),
                  tooltip: 'View',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: () => _showStatusUpdateDialog(feedback),
                  tooltip: 'Update Status',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                  onPressed: () => _showDeleteConfirmation(feedback),
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
      case 'Bug Report':
        return Colors.red;
      case 'Feature Request':
        return Colors.blue;
      case 'General':
        return Colors.green;
      case 'Complaint':
        return Colors.orange;
      case 'Suggestion':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'New':
        return Colors.orange;
      case 'In Review':
        return Colors.purple;
      case 'Resolved':
        return Colors.green;
      case 'Closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showFeedbackDetails(UserFeedback feedback) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
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
                    'Feedback Details',
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
                      _buildDetailRow('Subject', feedback.subject),
                      _buildDetailRow('User', feedback.userName),
                      _buildDetailRow('Email', feedback.userEmail),
                      _buildDetailRow('Category', feedback.category),
                      _buildDetailRow('Status', feedback.status),
                      _buildDetailRow('Priority', feedback.priority),
                      _buildDetailRow('Rating', '${feedback.rating}/5 stars'),
                      _buildDetailRow('Date', _formatDate(feedback.createdAt)),
                      const SizedBox(height: 16),
                      const Text(
                        'Message:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(feedback.message),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  void _showStatusUpdateDialog(UserFeedback feedback) {
    String selectedStatus = feedback.status;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Update status for: ${feedback.subject}'),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: _statuses.where((s) => s != 'All').map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) => selectedStatus = value!,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final index = _feedbacks.indexWhere((f) => f.id == feedback.id);
                if (index != -1) {
                  _feedbacks[index] = feedback.copyWith(status: selectedStatus);
                }
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Status updated successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF86C13C),
            ),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(UserFeedback feedback) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Feedback'),
        content: Text(
          'Are you sure you want to delete this feedback from "${feedback.userName}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _feedbacks.removeWhere((f) => f.id == feedback.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feedback deleted successfully'),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

// UserFeedback Model
class UserFeedback {
  final String id;
  final String userName;
  final String userEmail;
  final String category;
  final String subject;
  final String message;
  final String status;
  final String priority;
  final DateTime createdAt;
  final int rating;

  UserFeedback({
    required this.id,
    required this.userName,
    required this.userEmail,
    required this.category,
    required this.subject,
    required this.message,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.rating,
  });

  UserFeedback copyWith({
    String? id,
    String? userName,
    String? userEmail,
    String? category,
    String? subject,
    String? message,
    String? status,
    String? priority,
    DateTime? createdAt,
    int? rating,
  }) {
    return UserFeedback(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      category: category ?? this.category,
      subject: subject ?? this.subject,
      message: message ?? this.message,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
    );
  }
}
