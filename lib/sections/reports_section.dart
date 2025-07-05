import 'package:flutter/material.dart';
import '../widgets/stat_card.dart';
import '../widgets/report_list_item.dart';

class ReportsSection extends StatefulWidget {
  const ReportsSection({super.key});

  @override
  State<ReportsSection> createState() => _ReportsSectionState();
}

class _ReportsSectionState extends State<ReportsSection> {
  bool _isLoadingReports = false;

  // Mock Reports data
  final List<Map<String, dynamic>> _reports = [
    {
      'id': 1,
      'location': 'Colombo Municipal Area, Ward 15',
      'status': 'pending',
      'total_objects': 12,
      'reported_at': DateTime.now()
          .subtract(const Duration(hours: 2))
          .toIso8601String(),
    },
    {
      'id': 2,
      'location': 'Gampaha District, Main Road',
      'status': 'investigating',
      'total_objects': 8,
      'reported_at': DateTime.now()
          .subtract(const Duration(days: 1))
          .toIso8601String(),
    },
    {
      'id': 3,
      'location': 'Kandy Municipal Council Area',
      'status': 'resolved',
      'total_objects': 15,
      'reported_at': DateTime.now()
          .subtract(const Duration(days: 3))
          .toIso8601String(),
    },
  ];

  final Map<String, int> _reportStats = {
    'total': 25,
    'pending': 8,
    'resolved': 12,
    'thisMonth': 18,
  };

  @override
  void initState() {
    super.initState();
    _loadReportsData();
  }

  void _loadReportsData() {
    setState(() {
      _isLoadingReports = true;
    });

    // Simulate API call delay
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoadingReports = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Reports Management',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 24),

          // Stats Cards Row
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Total Reports',
                  value: _reportStats['total'].toString(),
                  icon: Icons.report,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: 'Pending',
                  value: _reportStats['pending'].toString(),
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: 'Resolved',
                  value: _reportStats['resolved'].toString(),
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: StatCard(
                  title: 'This Month',
                  value: _reportStats['thisMonth'].toString(),
                  icon: Icons.calendar_today,
                  color: Colors.purple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Reports List
          Expanded(
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'All Reports',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: _isLoadingReports
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.builder(
                              itemCount: _reports.length,
                              itemBuilder: (context, index) {
                                final report = _reports[index];
                                return ReportListItem(report: report);
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
