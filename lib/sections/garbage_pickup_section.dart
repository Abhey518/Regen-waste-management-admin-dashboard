import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Mock Service and Models (replace with actual imports)
class AdminGarbageScheduleService {
  // Mock implementation - replace with actual service
  Future<List<GarbagePickup>> getSchedulesWithFilters({
    int? provinceId,
    int? districtId,
    int? localAuthorityId,
    String? wasteType,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockSchedules;
  }

  Future<List<Province>> getProvinces() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockProvinces;
  }

  Future<List<District>> getDistricts(int provinceId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockDistricts.where((d) => d.provinceId == provinceId).toList();
  }

  Future<List<LocalAuthority>> getLocalAuthorities(int districtId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockLocalAuthorities
        .where((la) => la.districtId == districtId)
        .toList();
  }

  Future<bool> createSchedule({
    required int provinceId,
    required int districtId,
    required int localAuthorityId,
    required DateTime pickupDate,
    required String pickupTimeStart,
    required String pickupTimeEnd,
    required String wasteType,
    String status = 'scheduled',
    bool isRecurring = true,
    String recurrenceType = 'weekly',
    String? notes,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> updateSchedule({
    required String scheduleId,
    int? provinceId,
    int? districtId,
    int? localAuthorityId,
    DateTime? pickupDate,
    String? pickupTimeStart,
    String? pickupTimeEnd,
    String? wasteType,
    String? status,
    bool? isRecurring,
    String? recurrenceType,
    String? notes,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<bool> deleteSchedule(String scheduleId) async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<List<ScheduleTemplate>> getScheduleTemplates({
    int? provinceId,
    int? districtId,
    int? localAuthorityId,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockTemplates;
  }

  Future<bool> generateSchedulesFromTemplates() async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
}

// Data Models
class GarbagePickup {
  final String id;
  final int provinceId;
  final int districtId;
  final int localAuthorityId;
  final DateTime pickupDate;
  final String pickupTimeStart;
  final String pickupTimeEnd;
  final String wasteType;
  final String status;
  final bool isRecurring;
  final String recurrenceType;
  final String? createdBy;
  final String? notes;
  final String? provinceName;
  final String? districtName;
  final String? localAuthorityName;
  final String? fullLocationPath;

  GarbagePickup({
    required this.id,
    required this.provinceId,
    required this.districtId,
    required this.localAuthorityId,
    required this.pickupDate,
    required this.pickupTimeStart,
    required this.pickupTimeEnd,
    required this.wasteType,
    required this.status,
    required this.isRecurring,
    required this.recurrenceType,
    this.createdBy,
    this.notes,
    this.provinceName,
    this.districtName,
    this.localAuthorityName,
    this.fullLocationPath,
  });

  String get formattedTime12Hour {
    final startTime = _parseTime(pickupTimeStart);
    final endTime = _parseTime(pickupTimeEnd);
    return '${_formatTime12Hour(startTime)} - ${_formatTime12Hour(endTime)}';
  }

  DateTime _parseTime(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return DateTime(2000, 1, 1, hour, minute);
  }

  String _formatTime12Hour(DateTime time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$hour12:${minute.toString().padLeft(2, '0')} $period';
  }
}

class Province {
  final int id;
  final String name;
  Province({required this.id, required this.name});
}

class District {
  final int id;
  final String name;
  final int provinceId;
  District({required this.id, required this.name, required this.provinceId});
}

class LocalAuthority {
  final int id;
  final String name;
  final int districtId;
  LocalAuthority({
    required this.id,
    required this.name,
    required this.districtId,
  });
}

class ScheduleTemplate {
  final String id;
  final int provinceId;
  final int districtId;
  final int localAuthorityId;
  final int dayOfWeek;
  final String pickupTimeStart;
  final String pickupTimeEnd;
  final String wasteType;
  final bool isActive;
  final String? provinceName;
  final String? districtName;
  final String? localAuthorityName;
  final String? dayName;

  ScheduleTemplate({
    required this.id,
    required this.provinceId,
    required this.districtId,
    required this.localAuthorityId,
    required this.dayOfWeek,
    required this.pickupTimeStart,
    required this.pickupTimeEnd,
    required this.wasteType,
    required this.isActive,
    this.provinceName,
    this.districtName,
    this.localAuthorityName,
    this.dayName,
  });
}

// Mock Data
final List<Province> _mockProvinces = [
  Province(id: 1, name: 'Western Province'),
  Province(id: 2, name: 'Central Province'),
  Province(id: 3, name: 'Southern Province'),
];

final List<District> _mockDistricts = [
  District(id: 1, name: 'Colombo', provinceId: 1),
  District(id: 2, name: 'Gampaha', provinceId: 1),
  District(id: 3, name: 'Kandy', provinceId: 2),
  District(id: 4, name: 'Galle', provinceId: 3),
];

final List<LocalAuthority> _mockLocalAuthorities = [
  LocalAuthority(id: 1, name: 'Colombo Municipal Council', districtId: 1),
  LocalAuthority(id: 2, name: 'Dehiwala-Mount Lavinia MC', districtId: 1),
  LocalAuthority(id: 3, name: 'Negombo Municipal Council', districtId: 2),
  LocalAuthority(id: 4, name: 'Kandy Municipal Council', districtId: 3),
];

final List<GarbagePickup> _mockSchedules = [
  GarbagePickup(
    id: '1',
    provinceId: 1,
    districtId: 1,
    localAuthorityId: 1,
    pickupDate: DateTime.now().add(const Duration(days: 1)),
    pickupTimeStart: '08:00',
    pickupTimeEnd: '11:00',
    wasteType: 'Organic Waste',
    status: 'scheduled',
    isRecurring: true,
    recurrenceType: 'weekly',
    provinceName: 'Western Province',
    districtName: 'Colombo',
    localAuthorityName: 'Colombo Municipal Council',
    fullLocationPath: 'Western Province > Colombo > Colombo Municipal Council',
    notes: 'Regular weekly collection',
  ),
  GarbagePickup(
    id: '2',
    provinceId: 1,
    districtId: 1,
    localAuthorityId: 2,
    pickupDate: DateTime.now().add(const Duration(days: 2)),
    pickupTimeStart: '09:30',
    pickupTimeEnd: '12:30',
    wasteType: 'Plastic/Polythene',
    status: 'scheduled',
    isRecurring: true,
    recurrenceType: 'weekly',
    provinceName: 'Western Province',
    districtName: 'Colombo',
    localAuthorityName: 'Dehiwala-Mount Lavinia MC',
    fullLocationPath: 'Western Province > Colombo > Dehiwala-Mount Lavinia MC',
  ),
  GarbagePickup(
    id: '3',
    provinceId: 2,
    districtId: 3,
    localAuthorityId: 4,
    pickupDate: DateTime.now().add(const Duration(days: 3)),
    pickupTimeStart: '07:00',
    pickupTimeEnd: '10:00',
    wasteType: 'Organic Waste',
    status: 'in_progress',
    isRecurring: true,
    recurrenceType: 'weekly',
    provinceName: 'Central Province',
    districtName: 'Kandy',
    localAuthorityName: 'Kandy Municipal Council',
    fullLocationPath: 'Central Province > Kandy > Kandy Municipal Council',
  ),
];

final List<ScheduleTemplate> _mockTemplates = [
  ScheduleTemplate(
    id: 't1',
    provinceId: 1,
    districtId: 1,
    localAuthorityId: 1,
    dayOfWeek: 1,
    pickupTimeStart: '08:00',
    pickupTimeEnd: '11:00',
    wasteType: 'Organic Waste',
    isActive: true,
    provinceName: 'Western Province',
    districtName: 'Colombo',
    localAuthorityName: 'Colombo Municipal Council',
    dayName: 'Monday',
  ),
];

class GarbagePickupSection extends StatefulWidget {
  const GarbagePickupSection({super.key});

  @override
  State<GarbagePickupSection> createState() => _GarbagePickupSectionState();
}

class _GarbagePickupSectionState extends State<GarbagePickupSection> {
  final AdminGarbageScheduleService _adminService =
      AdminGarbageScheduleService();

  List<GarbagePickup> _schedules = [];
  List<Province> _provinces = [];
  List<District> _districts = [];
  List<LocalAuthority> _localAuthorities = [];

  Province? _selectedProvince;
  District? _selectedDistrict;
  LocalAuthority? _selectedLocalAuthority;
  String? _selectedWasteType;
  String? _selectedStatus;

  bool _isLoading = true;
  bool _isLoadingDistricts = false;
  bool _isLoadingLocalAuthorities = false;

  final List<String> _wasteTypes = ['Organic Waste', 'Plastic/Polythene'];
  final List<String> _statusTypes = [
    'scheduled',
    'in_progress',
    'completed',
    'cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      final provinces = await _adminService.getProvinces();
      final schedules = await _adminService.getSchedulesWithFilters();

      setState(() {
        _provinces = provinces;
        _schedules = schedules;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Failed to load data: $e');
    }
  }

  Future<void> _loadDistricts(int provinceId) async {
    setState(() => _isLoadingDistricts = true);

    try {
      final districts = await _adminService.getDistricts(provinceId);
      setState(() {
        _districts = districts;
        _selectedDistrict = null;
        _selectedLocalAuthority = null;
        _localAuthorities = [];
        _isLoadingDistricts = false;
      });
    } catch (e) {
      setState(() => _isLoadingDistricts = false);
      _showErrorSnackBar('Failed to load districts: $e');
    }
  }

  Future<void> _loadLocalAuthorities(int districtId) async {
    setState(() => _isLoadingLocalAuthorities = true);

    try {
      final localAuthorities = await _adminService.getLocalAuthorities(
        districtId,
      );
      setState(() {
        _localAuthorities = localAuthorities;
        _selectedLocalAuthority = null;
        _isLoadingLocalAuthorities = false;
      });
    } catch (e) {
      setState(() => _isLoadingLocalAuthorities = false);
      _showErrorSnackBar('Failed to load local authorities: $e');
    }
  }

  Future<void> _applyFilters() async {
    setState(() => _isLoading = true);

    try {
      final schedules = await _adminService.getSchedulesWithFilters(
        provinceId: _selectedProvince?.id,
        districtId: _selectedDistrict?.id,
        localAuthorityId: _selectedLocalAuthority?.id,
        wasteType: _selectedWasteType,
        status: _selectedStatus,
      );

      setState(() {
        _schedules = schedules;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Failed to apply filters: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  // Get filtered schedules for display
  List<GarbagePickup> _getFilteredSchedules() {
    return _schedules;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 24),
          _buildStatsCards(),
          const SizedBox(height: 24),
          _buildFiltersSection(),
          const SizedBox(height: 16),
          _buildSchedulesList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(Icons.local_shipping, size: 28, color: Color(0xFF2C3E50)),
        const SizedBox(width: 12),
        const Text(
          'Garbage Pickup Schedule Management',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const Spacer(),
        ElevatedButton.icon(
          onPressed: _showTemplatesDialog,
          icon: const Icon(Icons.view_list),
          label: const Text('Templates'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton.icon(
          onPressed: _showCreateScheduleDialog,
          icon: const Icon(Icons.add),
          label: const Text('Add Schedule'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[600],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    final scheduledCount = _schedules
        .where((s) => s.status == 'scheduled')
        .length;
    final inProgressCount = _schedules
        .where((s) => s.status == 'in_progress')
        .length;
    final completedCount = _schedules
        .where((s) => s.status == 'completed')
        .length;
    final totalSchedules = _schedules.length;

    return Row(
      children: [
        _buildStatCard(
          'Total Schedules',
          totalSchedules.toString(),
          Icons.schedule,
          Colors.blue,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'Scheduled',
          scheduledCount.toString(),
          Icons.access_time,
          Colors.orange,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'In Progress',
          inProgressCount.toString(),
          Icons.play_circle,
          Colors.green,
        ),
        const SizedBox(width: 16),
        _buildStatCard(
          'Completed',
          completedCount.toString(),
          Icons.check_circle,
          Colors.teal,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 24),
                const Spacer(),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFiltersSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.filter_list, size: 20),
              const SizedBox(width: 8),
              const Text(
                'Filters',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _clearFilters,
                icon: const Icon(Icons.clear, size: 16),
                label: const Text('Clear All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // First Row: Location Filters
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<Province>(
                  decoration: const InputDecoration(
                    labelText: 'Province',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: _selectedProvince,
                  items: _provinces
                      .map(
                        (province) => DropdownMenuItem(
                          value: province,
                          child: Text(province.name),
                        ),
                      )
                      .toList(),
                  onChanged: (province) {
                    setState(() {
                      _selectedProvince = province;
                      _selectedDistrict = null;
                      _selectedLocalAuthority = null;
                      _districts = [];
                      _localAuthorities = [];
                    });
                    if (province != null) {
                      _loadDistricts(province.id);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<District>(
                  decoration: const InputDecoration(
                    labelText: 'District',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: _selectedDistrict,
                  items: _districts
                      .map(
                        (district) => DropdownMenuItem(
                          value: district,
                          child: Text(district.name),
                        ),
                      )
                      .toList(),
                  onChanged: _isLoadingDistricts
                      ? null
                      : (district) {
                          setState(() {
                            _selectedDistrict = district;
                            _selectedLocalAuthority = null;
                            _localAuthorities = [];
                          });
                          if (district != null) {
                            _loadLocalAuthorities(district.id);
                          }
                        },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<LocalAuthority>(
                  decoration: const InputDecoration(
                    labelText: 'Local Authority',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: _selectedLocalAuthority,
                  items: _localAuthorities
                      .map(
                        (la) =>
                            DropdownMenuItem(value: la, child: Text(la.name)),
                      )
                      .toList(),
                  onChanged: _isLoadingLocalAuthorities
                      ? null
                      : (la) {
                          setState(() => _selectedLocalAuthority = la);
                        },
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Second Row: Type and Status Filters
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Waste Type',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: _selectedWasteType,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Types'),
                    ),
                    ..._wasteTypes.map(
                      (type) =>
                          DropdownMenuItem(value: type, child: Text(type)),
                    ),
                  ],
                  onChanged: (type) {
                    setState(() => _selectedWasteType = type);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                  value: _selectedStatus,
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Status'),
                    ),
                    ..._statusTypes.map(
                      (status) => DropdownMenuItem(
                        value: status,
                        child: Text(status.toUpperCase()),
                      ),
                    ),
                  ],
                  onChanged: (status) {
                    setState(() => _selectedStatus = status);
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(child: Container()), // Spacer
            ],
          ),
          const SizedBox(height: 16),
          // Action Buttons
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _applyFilters,
                icon: const Icon(Icons.search, size: 16),
                label: const Text('Apply Filters'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[600],
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _loadData,
                icon: const Icon(Icons.refresh),
                tooltip: 'Refresh',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSchedulesList() {
    final filteredSchedules = _getFilteredSchedules();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : filteredSchedules.isEmpty
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.schedule, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No schedules found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Try adjusting your filters or add a new schedule',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: filteredSchedules.length,
                itemBuilder: (context, index) {
                  final schedule = filteredSchedules[index];
                  return _buildScheduleCard(schedule);
                },
              ),
      ),
    );
  }

  Widget _buildScheduleCard(GarbagePickup schedule) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getWasteTypeColor(
                      schedule.wasteType,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    schedule.wasteType,
                    style: TextStyle(
                      color: _getWasteTypeColor(schedule.wasteType),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(
                      schedule.status,
                    ).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    schedule.status.toUpperCase(),
                    style: TextStyle(
                      color: _getStatusColor(schedule.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    switch (value) {
                      case 'edit':
                        _showEditScheduleDialog(schedule);
                        break;
                      case 'delete':
                        _showDeleteConfirmation(schedule);
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('Edit')),
                    const PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Text(
                  DateFormat('MMM dd, yyyy').format(schedule.pickupDate),
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Text(
                  schedule.formattedTime12Hour,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    schedule.fullLocationPath ?? 'N/A',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            if (schedule.notes?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.note, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      schedule.notes!,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ),
                ],
              ),
            ],
            if (schedule.isRecurring) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.repeat, size: 16, color: Colors.blue[600]),
                  const SizedBox(width: 6),
                  Text(
                    'Recurring ${schedule.recurrenceType}',
                    style: TextStyle(color: Colors.blue[600], fontSize: 12),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Helper Methods
  Color _getWasteTypeColor(String wasteType) {
    switch (wasteType) {
      case 'Organic Waste':
        return Colors.green;
      case 'Plastic/Polythene':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'scheduled':
        return Colors.orange;
      case 'in_progress':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedProvince = null;
      _selectedDistrict = null;
      _selectedLocalAuthority = null;
      _selectedWasteType = null;
      _selectedStatus = null;
      _districts = [];
      _localAuthorities = [];
    });
    _loadData();
  }

  // Dialog Methods
  void _showCreateScheduleDialog() {
    showDialog(
      context: context,
      builder: (context) => CreateScheduleDialog(
        adminService: _adminService,
        onScheduleCreated: () {
          _applyFilters();
          _showSuccessSnackBar('Schedule created successfully');
        },
      ),
    );
  }

  void _showEditScheduleDialog(GarbagePickup schedule) {
    showDialog(
      context: context,
      builder: (context) => EditScheduleDialog(
        adminService: _adminService,
        schedule: schedule,
        onScheduleUpdated: () {
          _applyFilters();
          _showSuccessSnackBar('Schedule updated successfully');
        },
      ),
    );
  }

  void _showTemplatesDialog() {
    showDialog(
      context: context,
      builder: (context) => ScheduleTemplatesDialog(
        adminService: _adminService,
        onTemplateAction: () {
          _applyFilters();
        },
      ),
    );
  }

  void _showDeleteConfirmation(GarbagePickup schedule) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Schedule'),
        content: Text(
          'Are you sure you want to delete this ${schedule.wasteType} pickup schedule for ${DateFormat('MMM dd, yyyy').format(schedule.pickupDate)}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await _adminService.deleteSchedule(schedule.id);
              if (success) {
                _applyFilters();
                _showSuccessSnackBar('Schedule deleted successfully');
              } else {
                _showErrorSnackBar('Failed to delete schedule');
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

// Create Schedule Dialog
class CreateScheduleDialog extends StatefulWidget {
  final AdminGarbageScheduleService adminService;
  final VoidCallback onScheduleCreated;

  const CreateScheduleDialog({
    super.key,
    required this.adminService,
    required this.onScheduleCreated,
  });

  @override
  State<CreateScheduleDialog> createState() => _CreateScheduleDialogState();
}

class _CreateScheduleDialogState extends State<CreateScheduleDialog> {
  final _formKey = GlobalKey<FormState>();
  final _notesController = TextEditingController();

  List<Province> _provinces = [];
  List<District> _districts = [];
  List<LocalAuthority> _localAuthorities = [];

  Province? _selectedProvince;
  District? _selectedDistrict;
  LocalAuthority? _selectedLocalAuthority;
  String? _selectedWasteType;
  String _selectedStatus = 'scheduled';
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _isRecurring = true;
  String _recurrenceType = 'weekly';

  bool _isLoading = true;
  bool _isSaving = false;

  final List<String> _wasteTypes = ['Organic Waste', 'Plastic/Polythene'];
  final List<String> _statusTypes = [
    'scheduled',
    'in_progress',
    'completed',
    'cancelled',
  ];
  final List<String> _recurrenceTypes = ['weekly', 'monthly', 'custom'];

  @override
  void initState() {
    super.initState();
    _loadProvinces();
  }

  Future<void> _loadProvinces() async {
    try {
      final provinces = await widget.adminService.getProvinces();
      setState(() {
        _provinces = provinces;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loadDistricts(int provinceId) async {
    try {
      final districts = await widget.adminService.getDistricts(provinceId);
      setState(() {
        _districts = districts;
        _selectedDistrict = null;
        _selectedLocalAuthority = null;
        _localAuthorities = [];
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _loadLocalAuthorities(int districtId) async {
    try {
      final localAuthorities = await widget.adminService.getLocalAuthorities(
        districtId,
      );
      setState(() {
        _localAuthorities = localAuthorities;
        _selectedLocalAuthority = null;
      });
    } catch (e) {
      // Handle error
    }
  }

  Future<void> _saveSchedule() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedProvince == null ||
        _selectedDistrict == null ||
        _selectedLocalAuthority == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select location')));
      return;
    }
    if (_selectedDate == null || _startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date and time')),
      );
      return;
    }

    setState(() => _isSaving = true);

    final success = await widget.adminService.createSchedule(
      provinceId: _selectedProvince!.id,
      districtId: _selectedDistrict!.id,
      localAuthorityId: _selectedLocalAuthority!.id,
      pickupDate: _selectedDate!,
      pickupTimeStart:
          '${_startTime!.hour.toString().padLeft(2, '0')}:${_startTime!.minute.toString().padLeft(2, '0')}',
      pickupTimeEnd:
          '${_endTime!.hour.toString().padLeft(2, '0')}:${_endTime!.minute.toString().padLeft(2, '0')}',
      wasteType: _selectedWasteType!,
      status: _selectedStatus,
      isRecurring: _isRecurring,
      recurrenceType: _recurrenceType,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    setState(() => _isSaving = false);

    if (success) {
      Navigator.pop(context);
      widget.onScheduleCreated();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to create schedule')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Schedule'),
      content: _isLoading
          ? const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            )
          : SizedBox(
              width: double.maxFinite,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Location Selection
                      DropdownButtonFormField<Province>(
                        decoration: const InputDecoration(
                          labelText: 'Province',
                        ),
                        value: _selectedProvince,
                        items: _provinces
                            .map(
                              (p) => DropdownMenuItem(
                                value: p,
                                child: Text(p.name),
                              ),
                            )
                            .toList(),
                        onChanged: (province) {
                          setState(() => _selectedProvince = province);
                          if (province != null) _loadDistricts(province.id);
                        },
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<District>(
                        decoration: const InputDecoration(
                          labelText: 'District',
                        ),
                        value: _selectedDistrict,
                        items: _districts
                            .map(
                              (d) => DropdownMenuItem(
                                value: d,
                                child: Text(d.name),
                              ),
                            )
                            .toList(),
                        onChanged: (district) {
                          setState(() => _selectedDistrict = district);
                          if (district != null)
                            _loadLocalAuthorities(district.id);
                        },
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<LocalAuthority>(
                        decoration: const InputDecoration(
                          labelText: 'Local Authority',
                        ),
                        value: _selectedLocalAuthority,
                        items: _localAuthorities
                            .map(
                              (la) => DropdownMenuItem(
                                value: la,
                                child: Text(la.name),
                              ),
                            )
                            .toList(),
                        onChanged: (la) =>
                            setState(() => _selectedLocalAuthority = la),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      // Date Selection
                      ListTile(
                        title: Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : DateFormat(
                                  'MMM dd, yyyy',
                                ).format(_selectedDate!),
                        ),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(
                              const Duration(days: 365),
                            ),
                          );
                          if (date != null)
                            setState(() => _selectedDate = date);
                        },
                      ),

                      // Time Selection
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                _startTime == null
                                    ? 'Start Time'
                                    : _startTime!.format(context),
                              ),
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null)
                                  setState(() => _startTime = time);
                              },
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                _endTime == null
                                    ? 'End Time'
                                    : _endTime!.format(context),
                              ),
                              onTap: () async {
                                final time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                                if (time != null)
                                  setState(() => _endTime = time);
                              },
                            ),
                          ),
                        ],
                      ),

                      // Waste Type
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Waste Type',
                        ),
                        value: _selectedWasteType,
                        items: _wasteTypes
                            .map(
                              (type) => DropdownMenuItem(
                                value: type,
                                child: Text(type),
                              ),
                            )
                            .toList(),
                        onChanged: (type) =>
                            setState(() => _selectedWasteType = type),
                        validator: (value) => value == null ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      // Status
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(labelText: 'Status'),
                        value: _selectedStatus,
                        items: _statusTypes
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(status.toUpperCase()),
                              ),
                            )
                            .toList(),
                        onChanged: (status) =>
                            setState(() => _selectedStatus = status!),
                      ),
                      const SizedBox(height: 12),

                      // Recurring Options
                      CheckboxListTile(
                        title: const Text('Recurring Schedule'),
                        value: _isRecurring,
                        onChanged: (value) =>
                            setState(() => _isRecurring = value ?? false),
                      ),
                      if (_isRecurring)
                        DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Recurrence Type',
                          ),
                          value: _recurrenceType,
                          items: _recurrenceTypes
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (type) => setState(
                            () => _recurrenceType = type ?? 'weekly',
                          ),
                        ),
                      const SizedBox(height: 12),

                      // Notes
                      TextFormField(
                        controller: _notesController,
                        decoration: const InputDecoration(
                          labelText: 'Notes (Optional)',
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      actions: [
        TextButton(
          onPressed: _isSaving ? null : () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _isSaving ? null : _saveSchedule,
          child: _isSaving
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('Create'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }
}

// Edit Schedule Dialog (simplified placeholder)
class EditScheduleDialog extends StatelessWidget {
  final AdminGarbageScheduleService adminService;
  final GarbagePickup schedule;
  final VoidCallback onScheduleUpdated;

  const EditScheduleDialog({
    super.key,
    required this.adminService,
    required this.schedule,
    required this.onScheduleUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Edit Schedule - ${schedule.wasteType}'),
      content: const Text('Edit schedule dialog will be implemented here.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            onScheduleUpdated();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

// Schedule Templates Dialog (simplified placeholder)
class ScheduleTemplatesDialog extends StatelessWidget {
  final AdminGarbageScheduleService adminService;
  final VoidCallback onTemplateAction;

  const ScheduleTemplatesDialog({
    super.key,
    required this.adminService,
    required this.onTemplateAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Schedule Templates'),
      content: const SizedBox(
        width: double.maxFinite,
        height: 300,
        child: Center(
          child: Text(
            'Schedule templates management will be implemented here.',
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}
