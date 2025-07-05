import 'package:flutter/material.dart';
import 'admin_login_page_new.dart';
import '../models/auth_models.dart';
import '../sections/dashboard_section.dart';
import '../sections/articles_section.dart';
import '../sections/reports_section.dart';
import '../sections/create_admin_section.dart';
import '../sections/users_section.dart';
import '../sections/categories_section.dart';
import '../sections/media_section.dart';
import '../sections/comments_section.dart';
import '../sections/analytics_section.dart';
import '../sections/settings_section.dart';

class AdminDashboard extends StatefulWidget {
  final AuthenticatedUser user;

  const AdminDashboard({super.key, required this.user});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  String _selectedMenuItem = 'Dashboard';

  // Menu items for the sidebar
  List<Map<String, dynamic>> get _menuItems {
    final baseItems = [
      {'title': 'Dashboard', 'icon': Icons.dashboard},
      {'title': 'Articles', 'icon': Icons.article},
      {'title': 'Reports', 'icon': Icons.report},
      {'title': 'Users', 'icon': Icons.people},
      {'title': 'Categories', 'icon': Icons.category},
      {'title': 'Media', 'icon': Icons.photo_library},
      {'title': 'Comments', 'icon': Icons.comment},
      {'title': 'Analytics', 'icon': Icons.analytics},
    ];

    // Add "Create Admin" for super admins only
    if (widget.user.role == UserRole.superAdmin) {
      baseItems.insert(3, {
        'title': 'Create Admin',
        'icon': Icons.admin_panel_settings,
      });
    }

    baseItems.add({'title': 'Settings', 'icon': Icons.settings});
    return baseItems;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Header Bar
          _buildHeaderBar(),
          // Main Content Area
          Expanded(
            child: Row(
              children: [
                // Left Sidebar (20% of screen)
                _buildSidebar(),
                // Right Content Area (80% of screen)
                Expanded(
                  child: Container(
                    color: const Color(0xFFF8F9FA),
                    child: _buildContentArea(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header Bar Widget
  Widget _buildHeaderBar() {
    return Container(
      height: 55,
      decoration: const BoxDecoration(
        color: Color(0xFF86C13C), // Green background
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 4),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Row(
          children: [
            // Left: App Title
            const Text(
              'Regen Admin Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            // Right: User info
            Row(
              children: [
                const Icon(Icons.account_circle, color: Colors.white, size: 32),
                const SizedBox(width: 8),
                Text(
                  widget.user.role == UserRole.superAdmin
                      ? 'Super Admin'
                      : 'Admin',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Sidebar Widget
  Widget _buildSidebar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      decoration: const BoxDecoration(
        color: Color(0xFF2C3E50),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 0)),
        ],
      ),
      child: Column(
        children: [
          // Logo/Brand Section
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                  child: const Icon(
                    Icons.admin_panel_settings,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Admin Panel',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                final isSelected = _selectedMenuItem == item['title'];

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  child: ListTile(
                    leading: Icon(
                      item['icon'],
                      color: isSelected ? Colors.white : Colors.grey[400],
                    ),
                    title: Text(
                      item['title'],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey[400],
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                    selected: isSelected,
                    selectedTileColor: Colors.white.withValues(alpha: 0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    onTap: () {
                      setState(() {
                        _selectedMenuItem = item['title'];
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Logout Button
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _handleLogout,
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Logout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[600],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentArea() {
    switch (_selectedMenuItem) {
      case 'Dashboard':
        return DashboardSection(user: widget.user);
      case 'Articles':
        return const ArticlesSection();
      case 'Reports':
        return const ReportsSection();
      case 'Create Admin':
        return const CreateAdminSection();
      case 'Users':
        return const UsersSection();
      case 'Categories':
        return const CategoriesSection();
      case 'Media':
        return const MediaSection();
      case 'Comments':
        return const CommentsSection();
      case 'Analytics':
        return const AnalyticsSection();
      case 'Settings':
        return const SettingsSection();
      default:
        return DashboardSection(user: widget.user);
    }
  }

  void _handleLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const AdminLoginScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}
