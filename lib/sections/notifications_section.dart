import 'package:flutter/material.dart';

class NotificationsSection extends StatefulWidget {
  const NotificationsSection({super.key});

  @override
  State<NotificationsSection> createState() => _NotificationsSectionState();
}

class _NotificationsSectionState extends State<NotificationsSection> {
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _selectedType = 'All';
  String _selectedPriority = 'All';

  final List<String> _notificationTypes = [
    'All',
    'general',
    'pickup',
    'urgent',
    'announcement',
  ];
  final List<String> _priorities = [
    'All',
    '1', // Low
    '2', // Medium
    '3', // High
  ];

  @override
  void initState() {
    super.initState();
    _loadMockData();
  }

  void _loadMockData() {
    // Mock notification data aligned with the actual NotificationModel
    _notifications = [
      NotificationModel(
        id: '1',
        title: 'New Quiz Categories Added!',
        message:
            'We\'ve added exciting new quiz categories: Ocean Conservation and Renewable Energy. Test your knowledge now!',
        type: 'announcement',
        isRead: false,
        userId: null, // Global notification
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        icon: 'campaign',
        priority: 2,
      ),
      NotificationModel(
        id: '2',
        title: 'Welcome to ReGen - Environmental Impact Tracker',
        message:
            'Thank you for joining ReGen! Start tracking your environmental impact and make a difference today.',
        type: 'general',
        isRead: false,
        userId: null,
        createdAt: DateTime.now().subtract(const Duration(days: 4)),
        updatedAt: DateTime.now().subtract(const Duration(days: 3)),
        icon: 'notifications',
        priority: 1,
      ),
      NotificationModel(
        id: '3',
        title: 'Pickup Reminder',
        message:
            'Your scheduled pickup is tomorrow at 2:00 PM. Please have your items ready.',
        type: 'pickup',
        isRead: true,
        userId: 'user_123',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 6)),
        icon: 'schedule',
        priority: 3,
      ),
      NotificationModel(
        id: '4',
        title: 'Urgent: System Maintenance',
        message:
            'Emergency maintenance will occur tonight from 2 AM to 4 AM EST. The app may be temporarily unavailable.',
        type: 'urgent',
        isRead: false,
        userId: null,
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
        icon: 'priority_high',
        priority: 3,
        expiresAt: DateTime.now().add(const Duration(hours: 12)),
      ),
      NotificationModel(
        id: '5',
        title: 'New Features Available!',
        message:
            'Check out our latest features: Enhanced tracking, community challenges, and improved rewards system.',
        type: 'general',
        isRead: true,
        userId: null,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        updatedAt: DateTime.now().subtract(const Duration(days: 7)),
        icon: 'notifications',
        priority: 1,
      ),
    ];
  }

  List<NotificationModel> get _filteredNotifications {
    return _notifications.where((notification) {
      final matchesSearch =
          notification.title.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          notification.message.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesType =
          _selectedType == 'All' || notification.type == _selectedType;
      final matchesPriority =
          _selectedPriority == 'All' ||
          notification.priority.toString() == _selectedPriority;
      return matchesSearch && matchesType && matchesPriority;
    }).toList();
  }

  String _getPriorityLabel(String priority) {
    switch (priority) {
      case '1':
        return 'Low Priority';
      case '2':
        return 'Medium Priority';
      case '3':
        return 'High Priority';
      default:
        return priority;
    }
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
                'User Notifications',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2C3E50),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _showCreateNotificationDialog(),
                icon: const Icon(Icons.add),
                label: const Text('Send Notification'),
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
                        labelText: 'Search notifications...',
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

                  // Type Filter
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedType,
                      decoration: InputDecoration(
                        labelText: 'Type',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _notificationTypes.map((type) {
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

                  // Priority Filter
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedPriority,
                      decoration: InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: _priorities.map((priority) {
                        return DropdownMenuItem(
                          value: priority,
                          child: Text(
                            priority == 'All'
                                ? 'All'
                                : _getPriorityLabel(priority),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => _selectedPriority = value!),
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
                'Total Notifications',
                _notifications.length.toString(),
                Icons.notifications,
                Colors.blue,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'Unread',
                _notifications.where((n) => !n.isRead).length.toString(),
                Icons.mark_email_unread,
                Colors.red,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'Global',
                _notifications.where((n) => n.isGlobal).length.toString(),
                Icons.public,
                Colors.purple,
              ),
              const SizedBox(width: 16),
              _buildStatCard(
                'High Priority',
                _notifications.where((n) => n.priority == 3).length.toString(),
                Icons.priority_high,
                Colors.orange,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Notifications Table
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
                            'Title & Type',
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
                            'Priority & Type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Status & Target',
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
                            itemCount: _filteredNotifications.length,
                            itemBuilder: (context, index) {
                              final notification =
                                  _filteredNotifications[index];
                              return _buildNotificationRow(notification, index);
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

  Widget _buildNotificationRow(NotificationModel notification, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(
        children: [
          // Title & Type
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: _getTypeColor(
                      notification.type,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getTypeDisplayName(notification.type),
                    style: TextStyle(
                      color: _getTypeColor(notification.type),
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Message
          Expanded(
            flex: 2,
            child: Text(
              notification.message,
              style: const TextStyle(fontSize: 13),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Priority & Type
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: notification.priorityColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    notification.priorityLabel,
                    style: TextStyle(
                      color: notification.priorityColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  notification.type.toUpperCase(),
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // Read Status & Global
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: notification.isRead
                        ? Colors.green.withValues(alpha: 0.1)
                        : Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    notification.isRead ? 'Read' : 'Unread',
                    style: TextStyle(
                      color: notification.isRead ? Colors.green : Colors.orange,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
                if (notification.isGlobal)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'GLOBAL',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Created Date
          Expanded(
            child: Text(
              notification.formattedTime,
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
                  onPressed: () => _showNotificationDetails(notification),
                  tooltip: 'View Details',
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18),
                  onPressed: !notification.isExpired
                      ? () => _showEditNotificationDialog(notification)
                      : null,
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                  onPressed: () => _showDeleteConfirmation(notification),
                  tooltip: 'Delete',
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
      case 'general':
        return 'General';
      case 'pickup':
        return 'Pickup';
      case 'urgent':
        return 'Urgent';
      case 'announcement':
        return 'Announcement';
      default:
        return type;
    }
  }

  Color _getTypeColor(String type) {
    switch (type) {
      case 'general':
        return Colors.blue;
      case 'pickup':
        return Colors.purple;
      case 'urgent':
        return Colors.red;
      case 'announcement':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _showCreateNotificationDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateNotificationDialog(
        onSave: (notification) {
          setState(() {
            _notifications.insert(0, notification);
          });
        },
      ),
    );
  }

  void _showEditNotificationDialog(NotificationModel notification) {
    showDialog(
      context: context,
      builder: (context) => CreateNotificationDialog(
        notification: notification,
        onSave: (updatedNotification) {
          setState(() {
            final index = _notifications.indexWhere(
              (n) => n.id == notification.id,
            );
            if (index != -1) {
              _notifications[index] = updatedNotification;
            }
          });
        },
      ),
    );
  }

  void _showNotificationDetails(NotificationModel notification) {
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
                    'Notification Details',
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
                      _buildDetailRow('Title', notification.title),
                      _buildDetailRow(
                        'Type',
                        _getTypeDisplayName(notification.type),
                      ),
                      _buildDetailRow('Priority', notification.priorityLabel),
                      _buildDetailRow(
                        'Read Status',
                        notification.isRead ? 'Read' : 'Unread',
                      ),
                      _buildDetailRow(
                        'Target',
                        notification.isGlobal
                            ? 'All Users (Global)'
                            : 'Specific User',
                      ),
                      if (notification.userId != null)
                        _buildDetailRow('User ID', notification.userId!),
                      if (notification.expiresAt != null)
                        _buildDetailRow(
                          'Expires',
                          _formatFullDate(notification.expiresAt!),
                        ),
                      if (notification.actionUrl != null)
                        _buildDetailRow('Action URL', notification.actionUrl!),
                      _buildDetailRow(
                        'Created',
                        _formatFullDate(notification.createdAt),
                      ),
                      _buildDetailRow(
                        'Last Updated',
                        _formatFullDate(notification.updatedAt),
                      ),
                      const SizedBox(height: 16),
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
                        child: Text(notification.message),
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
            width: 120,
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

  void _showDeleteConfirmation(NotificationModel notification) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Notification'),
        content: Text(
          'Are you sure you want to delete "${notification.title}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _notifications.removeWhere((n) => n.id == notification.id);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notification deleted successfully'),
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

  String _formatFullDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// Create Notification Dialog
class CreateNotificationDialog extends StatefulWidget {
  final NotificationModel? notification;
  final Function(NotificationModel) onSave;

  const CreateNotificationDialog({
    super.key,
    this.notification,
    required this.onSave,
  });

  @override
  State<CreateNotificationDialog> createState() =>
      _CreateNotificationDialogState();
}

class _CreateNotificationDialogState extends State<CreateNotificationDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _messageController;
  late String _selectedType;
  late String _selectedAudience;
  DateTime? _scheduledDate;
  bool _sendImmediately = false;

  final List<String> _types = ['general', 'pickup', 'urgent', 'announcement'];
  final List<String> _audiences = [
    'all_users',
    'specific_user',
    'active_users',
    'subscribed_users',
  ];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.notification?.title ?? '',
    );
    _messageController = TextEditingController(
      text: widget.notification?.message ?? '',
    );
    _selectedType = widget.notification?.type ?? 'general';
    _selectedAudience = widget.notification?.isGlobal == false
        ? 'specific_user'
        : 'all_users';
    _scheduledDate = widget.notification?.expiresAt;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _messageController.dispose();
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
                widget.notification != null
                    ? 'Edit Notification'
                    : 'Create New Notification',
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

                      // Type
                      DropdownButtonFormField<String>(
                        value: _selectedType,
                        decoration: const InputDecoration(
                          labelText: 'Type',
                          border: OutlineInputBorder(),
                        ),
                        items: _types.map((type) {
                          return DropdownMenuItem(
                            value: type,
                            child: Text(
                              type.substring(0, 1).toUpperCase() +
                                  type.substring(1),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _selectedType = value!),
                      ),
                      const SizedBox(height: 16),

                      // Target Audience
                      DropdownButtonFormField<String>(
                        value: _selectedAudience,
                        decoration: const InputDecoration(
                          labelText: 'Target Audience',
                          border: OutlineInputBorder(),
                        ),
                        items: _audiences.map((audience) {
                          return DropdownMenuItem(
                            value: audience,
                            child: Text(
                              audience
                                  .replaceAll('_', ' ')
                                  .split(' ')
                                  .map(
                                    (word) =>
                                        word.substring(0, 1).toUpperCase() +
                                        word.substring(1),
                                  )
                                  .join(' '),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _selectedAudience = value!),
                      ),
                      const SizedBox(height: 16),

                      // Message
                      TextFormField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          labelText: 'Message',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 4,
                        validator: (value) => value?.isEmpty ?? true
                            ? 'Message is required'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Send immediately checkbox
                      CheckboxListTile(
                        title: const Text('Send immediately'),
                        value: _sendImmediately,
                        onChanged: (value) {
                          setState(() {
                            _sendImmediately = value!;
                            if (value) _scheduledDate = null;
                          });
                        },
                      ),

                      if (!_sendImmediately) ...[
                        const SizedBox(height: 16),
                        // Schedule Date
                        ListTile(
                          title: Text(
                            'Schedule for: ${_scheduledDate != null ? _formatDate(_scheduledDate!) : 'Not set'}',
                          ),
                          trailing: const Icon(Icons.calendar_today),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate:
                                  _scheduledDate ??
                                  DateTime.now().add(const Duration(days: 1)),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (date != null) {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (time != null) {
                                setState(() {
                                  _scheduledDate = DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                  );
                                });
                              }
                            }
                          },
                        ),
                      ],
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
                    onPressed: _saveNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF86C13C),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(_sendImmediately ? 'Send Now' : 'Schedule'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveNotification() {
    if (_formKey.currentState!.validate()) {
      if (!_sendImmediately && _scheduledDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please select a schedule date or choose to send immediately',
            ),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final notification = NotificationModel(
        id:
            widget.notification?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        message: _messageController.text,
        type: _selectedType,
        isRead: false,
        userId: _selectedAudience == 'specific_user'
            ? 'user_example'
            : null, // In real app, this would be selected
        createdAt: widget.notification?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
        expiresAt: _scheduledDate,
        icon: _getIconForType(_selectedType),
        priority: _getPriorityForType(_selectedType),
      );

      widget.onSave(notification);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _sendImmediately
                ? 'Notification sent successfully'
                : 'Notification scheduled successfully',
          ),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  String _getIconForType(String type) {
    switch (type) {
      case 'general':
        return 'notifications';
      case 'pickup':
        return 'schedule';
      case 'urgent':
        return 'priority_high';
      case 'announcement':
        return 'campaign';
      default:
        return 'notifications';
    }
  }

  int _getPriorityForType(String type) {
    switch (type) {
      case 'urgent':
        return 3; // High priority
      case 'pickup':
      case 'announcement':
        return 2; // Medium priority
      case 'general':
        return 1; // Low priority
      default:
        return 1;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}

// NotificationModel - Aligned with the actual app's notification service
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final String? userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? expiresAt;
  final String icon;
  final String? actionUrl;
  final int priority;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.expiresAt,
    required this.icon,
    this.actionUrl,
    required this.priority,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      type: json['type'],
      isRead: json['is_read'] ?? false,
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : null,
      icon: json['icon'] ?? 'notifications',
      actionUrl: json['action_url'],
      priority: json['priority'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'type': type,
      'is_read': isRead,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
      'icon': icon,
      'action_url': actionUrl,
      'priority': priority,
    };
  }

  // Helper method to get icon data based on type
  String get iconName {
    switch (type) {
      case 'general':
        return 'notifications';
      case 'pickup':
        return 'schedule';
      case 'urgent':
        return 'priority_high';
      case 'announcement':
        return 'campaign';
      default:
        return icon;
    }
  }

  // Helper method to check if notification is expired
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  // Helper method to get formatted time
  String get formattedTime {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }
  }

  // Helper method to get priority label
  String get priorityLabel {
    switch (priority) {
      case 1:
        return 'Low';
      case 2:
        return 'Medium';
      case 3:
        return 'High';
      default:
        return 'Normal';
    }
  }

  // Helper method to get priority color
  Color get priorityColor {
    switch (priority) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.orange;
      case 3:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Helper to determine if notification is global (sent to all users)
  bool get isGlobal => userId == null;
}
