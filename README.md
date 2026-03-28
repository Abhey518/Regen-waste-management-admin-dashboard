# ReGen Admin Panel

A comprehensive Flutter web application for managing the ReGen Environmental Impact Tracker platform. This admin panel provides administrators with tools to manage users, notifications, articles, kids content, user feedback, and analytics.

## 🌟 Features

### 🔐 Authentication
- **Secure Login System** with role-based access (Admin/Super Admin)
- **Modern Two-Column Layout** with professional branding
- **Role-based Dashboard Access** with different permissions

### 📊 Dashboard Overview
- **Real-time Statistics** and metrics
- **Quick Action Buttons** for common tasks
- **Responsive Design** for all screen sizes
- **Clean, Professional UI** with ReGen branding

### 👥 User Management
- **User Registration Overview** with detailed statistics
- **User Activity Monitoring** and engagement metrics
- **Account Status Management** (Active/Inactive users)
- **Comprehensive User Profiles** with environmental impact data

### 📢 Notifications Management
- **Four Notification Types:**
  - `general` - General announcements and updates
  - `pickup` - Waste pickup reminders and schedules
  - `urgent` - Emergency alerts and critical updates
  - `announcement` - Official company announcements
- **Priority-based System** (Low/Medium/High)
- **Global & Targeted Messaging** (All users or specific users)
- **Scheduling & Immediate Send** options
- **Real-time Status Tracking** (Read/Unread)

### 📰 Articles Management
- **Full CRUD Operations** for environmental articles
- **Category Management** (Sustainability, Recycling, etc.)
- **Rich Content Editor** with media support
- **Publication Status Control** (Draft/Published)
- **SEO-friendly URL Management**

### 🧒 Kids Content Management
- **Educational Quiz Management** for children
- **Age-appropriate Content** filtering
- **Interactive Learning Materials** organization
- **Progress Tracking** for young users

### 💬 User Feedback System
- **Feedback Collection** and categorization
- **Response Management** with admin replies
- **Status Tracking** (Pending/In Progress/Resolved)
- **Priority Assignment** for urgent feedback

### 📈 Analytics & Reports
- **User Engagement Metrics** and trends
- **Environmental Impact Statistics** 
- **Platform Usage Analytics**
- **Exportable Reports** for stakeholders

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.32.5)
- Dart SDK (^3.5.0)
- Chrome browser for web development
- Git for version control

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/regen-admin-panel.git
   cd regen-admin-panel
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run -d chrome
   ```

### Development Setup

1. **For web development:**
   ```bash
   flutter run -d chrome --web-renderer html
   ```

2. **For building production:**
   ```bash
   flutter build web --release
   ```

## 🏗️ Project Structure

```
lib/
├── main.dart                          # Application entry point
├── models/                            # Data models
│   └── auth_models.dart              # Authentication models
├── screens/                           # Main application screens
│   ├── admin_login_page_new.dart     # Login interface
│   └── admin_dashboard.dart          # Main dashboard
└── sections/                          # Dashboard sections
    ├── dashboard_section.dart         # Overview dashboard
    ├── users_section.dart            # User management
    ├── notifications_section.dart     # Notification management
    ├── articles_section.dart         # Article management
    ├── kids_section.dart             # Kids content management
    ├── user_feedback_section.dart    # Feedback management
    ├── analytics_section.dart        # Analytics and reports
    ├── settings_section.dart         # System settings
    └── create_admin_section.dart     # Admin creation (Super Admin)
```

## 🎨 Design System

### Color Palette
- **Primary Green:** `#86C13C` - Main brand color
- **Dark Navy:** `#2C3E50` - Text and sidebar
- **Light Gray:** `#F8F9FA` - Background
- **Accent Colors:** Blue, Purple, Orange, Red for status indicators

### Typography
- **Headers:** Bold, clean sans-serif
- **Body Text:** Readable, accessible fonts
- **UI Elements:** Consistent sizing and spacing

## 🔧 Configuration

### Environment Setup
The application currently runs in standalone mode with mock data. For production:

1. **Configure Backend Integration**
   - Update API endpoints in service files
   - Configure Supabase connection
   - Set up authentication providers

2. **Environment Variables**
   ```dart
   // Add to main.dart or config file
   const String API_BASE_URL = 'your-api-url';
   const String SUPABASE_URL = 'your-supabase-url';
   const String SUPABASE_ANON_KEY = 'your-anon-key';
   ```

## 📱 Responsive Design

The admin panel is fully responsive and works on:
- **Desktop:** Full dashboard with sidebar navigation
- **Tablet:** Optimized layout with collapsible sidebar
- **Mobile:** Touch-friendly interface with bottom navigation

## 🔒 Security Features

- **Role-based Access Control** (RBAC)
- **Secure Authentication** with session management
- **Input Validation** and sanitization
- **XSS Protection** for user-generated content
- **CSRF Protection** for forms

## 🌍 Notification System Integration

The admin panel is designed to work with the ReGen app's notification service:

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is proprietary software. All rights reserved.

## 📞 Support

For support and questions:
- **Email:** arunodaabey2001@gmail.com
- **Issues:** GitHub Issues tab

## 🔄 Version History

- **v1.0.0** - Initial release with core functionality
- **v1.1.0** - Added notifications management
- **v1.2.0** - Enhanced user feedback system
- **v1.3.0** - Improved analytics dashboard

---

**Built with ❤️ for environmental sustainability**
