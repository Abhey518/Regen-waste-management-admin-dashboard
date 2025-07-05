import 'package:flutter/material.dart';
import '../models/auth_models.dart';
import '../widgets/stat_card.dart';

class DashboardSection extends StatelessWidget {
  final AuthenticatedUser user;

  const DashboardSection({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Dashboard Overview',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                'Welcome, ${user.role == UserRole.superAdmin ? 'Super Admin' : 'Admin'}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // Stats Cards
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 3.0,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              children: const [
                StatCard(
                  title: 'Total Articles',
                  value: '156',
                  icon: Icons.article,
                  color: Color(0xFF86c13c),
                ),
                StatCard(
                  title: 'Active Users',
                  value: '1,234',
                  icon: Icons.people,
                  color: Colors.blue,
                ),
                StatCard(
                  title: 'Views Today',
                  value: '5,678',
                  icon: Icons.visibility,
                  color: Colors.orange,
                ),
                StatCard(
                  title: 'Comments',
                  value: '892',
                  icon: Icons.comment,
                  color: Colors.purple,
                ),
                StatCard(
                  title: 'Likes',
                  value: '3,421',
                  icon: Icons.favorite,
                  color: Colors.red,
                ),
                StatCard(
                  title: 'Shares',
                  value: '567',
                  icon: Icons.share,
                  color: Colors.teal,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
