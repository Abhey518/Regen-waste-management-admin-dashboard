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
  String _selectedType = 'All';
  String _selectedStatus = 'All';

  final List<String> _feedbackTypes = [
    'All',
    'feedback',
    'suggestion',
    'bug_report',
  ];
  final List<String> _statuses = [
    'All',
    'pending',
    'in_review',
    'resolved',
    'closed',
  ];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    // Mock data matching your Supabase schema
    _feedbacks = [
      UserFeedback(
        id: '550e8400-e29b-41d4-a716-446655440001',
        userId: '123e4567-e89b-12d3-a456-426614174000',
        email: 'john.doe@example.com',
        feedbackType: 'feedback',
        message:
            'I love using this app! It has helped me learn so much about environmental conservation. The kids section is particularly engaging for my children.',
        status: 'resolved',
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 12)),
        adminResponse:
            'Thank you for your positive feedback! We\'re glad you and your children are enjoying the app.',
        adminId: 'admin-123',
        resolvedAt: DateTime.now().subtract(const Duration(hours: 12)),
      ),
      UserFeedback(
        id: '550e8400-e29b-41d4-a716-446655440002',
        userId: '123e4567-e89b-12d3-a456-426614174001',
        email: 'jane.smith@example.com',
        feedbackType: 'bug_report',
        message:
            'The app crashes every time I try to login with my Google account. This happens consistently on my Android device (Samsung Galaxy S21).',
        status: 'in_review',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        adminResponse:
            'We\'ve identified the issue and our development team is working on a fix. Expected resolution in the next app update.',
        adminId: 'admin-456',
      ),
      UserFeedback(
        id: '550e8400-e29b-41d4-a716-446655440003',
        userId: null, // Anonymous feedback
        email: 'mike.wilson@example.com',
        feedbackType: 'suggestion',
        message:
            'Please add more quiz categories like ocean conservation and renewable energy. Also, it would be great to have offline mode for the kids section.',
        status: 'pending',
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
      UserFeedback(
        id: '550e8400-e29b-41d4-a716-446655440004',
        userId: '123e4567-e89b-12d3-a456-426614174002',
        email: 'sarah.brown@example.com',
        feedbackType: 'feedback',
        message:
            'The recycling information is very helpful, but some of the images take too long to load. Could you optimize them?',
        status: 'closed',
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 4)),
        adminResponse:
            'Images have been optimized in version 2.1.0. Thank you for the feedback!',
        adminId: 'admin-123',
        resolvedAt: DateTime.now().subtract(const Duration(days: 4)),
      ),
      UserFeedback(
        id: '550e8400-e29b-41d4-a716-446655440005',
        userId: '123e4567-e89b-12d3-a456-426614174003',
        email: null, // User didn't provide email
        feedbackType: 'bug_report',
        message:
            'When I try to take a quiz in the kids section, sometimes the answers don\'t register when I tap them. This is frustrating for my children.',
        status: 'pending',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
      ),
    ];
  }

  List<UserFeedback> get _filteredFeedbacks {
    return _feedbacks.where((feedback) {
      final matchesSearch =
          feedback.message.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (feedback.email?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (feedback.adminResponse?.toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ??
              false);
      final matchesType =
          _selectedType == 'All' || feedback.feedbackType == _selectedType;
      final matchesStatus =
          _selectedStatus == 'All' || feedback.status == _selectedStatus;
      return matchesSearch && matchesType && matchesStatus;
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

                      // Feedback Type Filter
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _selectedType,
                          decoration: InputDecoration(
                            labelText: 'Feedback Type',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          items: _feedbackTypes.map((type) {
                            return DropdownMenuItem(
                              value: type,
                              child: Text(_getTypeDisplayName(type)),
                            );
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _selectedType = value!),
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
                              child: Text(_getStatusDisplayName(status)),
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
                'Pending',
                _feedbacks
                    .where((f) => f.status == 'pending')
                    .length
                    .toString(),
                Icons.pending,
                Colors.orange,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'In Review',
                _feedbacks
                    .where((f) => f.status == 'in_review')
                    .length
                    .toString(),
                Icons.rate_review,
                Colors.purple,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'Resolved',
                _feedbacks
                    .where(
                      (f) => f.status == 'resolved' || f.status == 'closed',
                    )
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
                            'User & Type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Message',
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
                            'Date',
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
          // User & Type
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getTypeIcon(feedback.feedbackType),
                      size: 16,
                      color: _getTypeColor(feedback.feedbackType),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _getTypeDisplayName(feedback.feedbackType),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: _getTypeColor(feedback.feedbackType),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  feedback.email ?? 'Anonymous User',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
          ),

          // Message
          Expanded(
            flex: 2,
            child: Text(
              feedback.message,
              style: const TextStyle(fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
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
                _getStatusDisplayName(feedback.status),
                style: TextStyle(
                  color: _getStatusColor(feedback.status),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Date
          Expanded(
            child: Text(
              _formatDate(feedback.createdAt),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
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
                  tooltip: 'View Details',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: () => _showUpdateStatusDialog(feedback),
                  tooltip: 'Update Status',
                ),
                IconButton(
                  icon: const Icon(Icons.reply, size: 18, color: Colors.blue),
                  onPressed: () => _showResponseDialog(feedback),
                  tooltip: 'Add Response',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getTypeDisplayName(String type) {
    switch (type) {
      case 'All':
        return 'All Types';
      case 'feedback':
        return 'Feedback';
      case 'suggestion':
        return 'Suggestion';
      case 'bug_report':
        return 'Bug Report';
      default:
        return type;
    }
  }

  String _getStatusDisplayName(String status) {
    switch (status) {
      case 'All':
        return 'All Statuses';
      case 'pending':
        return 'Pending';
      case 'in_review':
        return 'In Review';
      case 'resolved':
        return 'Resolved';
      case 'closed':
        return 'Closed';
      default:
        return status;
    }
  }

  IconData _getTypeIcon(String type) {
    switch (type) {
      case 'feedback':
        return Icons.feedback_outlined;
      case 'suggestion':
        return Icons.lightbulb_outline;
      case 'bug_report':
        return Icons.bug_report_outlined;
      default:
        return Icons.help_outline;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'feedback':
        return Colors.blue;
      case 'suggestion':
        return Colors.green;
      case 'bug_report':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.orange;
      case 'in_review':
        return Colors.purple;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  void _showFeedbackDetails(UserFeedback feedback) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 600,
          height: 700,
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
                      // Feedback Info
                      _buildDetailRow('ID', feedback.id),
                      _buildDetailRow(
                        'User ID',
                        feedback.userId ?? 'Anonymous',
                      ),
                      _buildDetailRow(
                        'Email',
                        feedback.email ?? 'Not provided',
                      ),
                      _buildDetailRow(
                        'Type',
                        _getTypeDisplayName(feedback.feedbackType),
                      ),
                      _buildDetailRow(
                        'Status',
                        _getStatusDisplayName(feedback.status),
                      ),
                      _buildDetailRow(
                        'Created',
                        _formatFullDate(feedback.createdAt),
                      ),
                      _buildDetailRow(
                        'Updated',
                        _formatFullDate(feedback.updatedAt),
                      ),
                      if (feedback.resolvedAt != null)
                        _buildDetailRow(
                          'Resolved',
                          _formatFullDate(feedback.resolvedAt!),
                        ),
                      const SizedBox(height: 16),

                      // Message
                      const Text(
                        'Message:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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
                      const SizedBox(height: 16),

                      // Admin Response
                      const Text(
                        'Admin Response:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: feedback.adminResponse != null
                              ? Colors.blue[50]
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: feedback.adminResponse != null
                                ? Colors.blue[200]!
                                : Colors.grey[300]!,
                          ),
                        ),
                        child: Text(
                          feedback.adminResponse ?? 'No response yet',
                          style: TextStyle(
                            fontStyle: feedback.adminResponse == null
                                ? FontStyle.italic
                                : FontStyle.normal,
                            color: feedback.adminResponse == null
                                ? Colors.grey[600]
                                : Colors.black,
                          ),
                        ),
                      ),
                      if (feedback.adminId != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          'Responded by: ${feedback.adminId}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
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

  void _showUpdateStatusDialog(UserFeedback feedback) {
    String selectedStatus = feedback.status;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Status'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update status for feedback: ${feedback.message.substring(0, 50)}...',
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
              items: _statuses.where((s) => s != 'All').map((status) {
                return DropdownMenuItem(
                  value: status,
                  child: Text(_getStatusDisplayName(status)),
                );
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
                  _feedbacks[index] = feedback.copyWith(
                    status: selectedStatus,
                    updatedAt: DateTime.now(),
                    resolvedAt:
                        (selectedStatus == 'resolved' ||
                            selectedStatus == 'closed')
                        ? DateTime.now()
                        : null,
                  );
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

  void _showResponseDialog(UserFeedback feedback) {
    final responseController = TextEditingController(
      text: feedback.adminResponse ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 500,
          height: 400,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Admin Response',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text('Feedback: ${feedback.message.substring(0, 100)}...'),
              const SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: responseController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    labelText: 'Admin Response',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        final index = _feedbacks.indexWhere(
                          (f) => f.id == feedback.id,
                        );
                        if (index != -1) {
                          _feedbacks[index] = feedback.copyWith(
                            adminResponse: responseController.text,
                            adminId:
                                'current-admin-id', // Replace with actual admin ID
                            updatedAt: DateTime.now(),
                          );
                        }
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Response added successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF86C13C),
                    ),
                    child: const Text('Save Response'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatFullDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// UserFeedback Model matching Supabase schema
class UserFeedback {
  final String id; // UUID
  final String? userId; // UUID, nullable for anonymous feedback
  final String? email; // VARCHAR(255), nullable
  final String feedbackType; // feedback, suggestion, bug_report
  final String message; // TEXT
  final String status; // pending, in_review, resolved, closed
  final DateTime createdAt; // TIMESTAMPTZ
  final DateTime updatedAt; // TIMESTAMPTZ
  final String? adminResponse; // TEXT, nullable
  final String? adminId; // UUID, nullable
  final DateTime? resolvedAt; // TIMESTAMPTZ, nullable

  UserFeedback({
    required this.id,
    this.userId,
    this.email,
    required this.feedbackType,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.adminResponse,
    this.adminId,
    this.resolvedAt,
  });

  UserFeedback copyWith({
    String? id,
    String? userId,
    String? email,
    String? feedbackType,
    String? message,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? adminResponse,
    String? adminId,
    DateTime? resolvedAt,
  }) {
    return UserFeedback(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      feedbackType: feedbackType ?? this.feedbackType,
      message: message ?? this.message,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      adminResponse: adminResponse ?? this.adminResponse,
      adminId: adminId ?? this.adminId,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }
}
