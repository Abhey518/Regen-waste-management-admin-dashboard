# ReGen – Rethink, Reduce, Recycle
### Web Administration Dashboard
**Subject:** Academic Project (2nd Year)

---

## 👥 Group Members & Contributions

| Name | Student ID | Implemented Module / Responsibilities |
| :--- | :--- | :--- |
| **Abeywardhana A. A. / Arunoda Abeywardhana** | `CT/2021/072` | **Project Lead** • Guided & developed the frontend • Developed the backend • Guided & developed the admin dashboard • Trained and developed the [garbage classification & proportion analyser model](https://github.com/Abhey518/Regen-object-detection-analyser) |
| **Mohan D. / Divyaloshini Mohan** | `CT/2021/085` | **Frontend Layouts & Documentation Lead** • Developed initial layouts for all application screens • Led the project documentation |
| **Pahalawaththa P. R. / Pasindu Randima** | `CT/2021/056` | **Backend & Database Lead** • Guided and implemented backend integration • Database management |
| **Jayamal B. M. / Bhanuka Malitha** | `CT/2021/058` | **Design & Admin Frontend Layout** • UI design • Guided and developed poster design • Developed initial layout for the Admin dashboard |
| **Wijewardhana P. P. A. / Piyumi Wijewardhana** | `CT/2021/015` | **Design & Documentation Support** • UI design • Poster design • Project documentation support |

---

## 📝 System Description
**ReGen Web Administration Dashboard** is a comprehensive, responsive web management interface built with Flutter to support municipal waste management operations. It acts as the command center for the ReGen platform, enabling administrative authorities to coordinate garbage collection routes, review reports, broadcast notices, and moderate learning channels.

The dashboard integrates directly with Supabase and PostgreSQL backend database routines. Through this system, local government officials can publish schedules, manage system notifications, track illegal dumping uploads (accompanied by GPS targeting coordinates), review user suggestions, and inspect visual analytics representing active user counts and feedback resolution speeds.

---

## 🛠️ Technology Stack

* **Frontend Framework:** Flutter (Dart Web)
* **Backend Integration:** Supabase Authentication, Supabase Storage
* **Database Engine:** PostgreSQL (Supabase)
* **Collaboration & Tools:** Git, GitHub, VS Code

---

## 🗄️ Database Architecture
The dashboard connects directly to the Supabase database. The central tables utilized by this management app include:
* `users`: Tracking active accounts and assigning administrative roles.
* `garbage_pickup_schedule` & `area_schedule_templates`: Supporting template curation and automated schedule generation.
* `dumping_reports`: Logging coordinate details, waste item counts, and status changes.
* `notifications`: Broadcaster database for alerts and push notifications.
* `feedback`: User suggestions, bug reports, and responses.

---

## 🎯 Main Features & Responsibilities

### 1. User & Access Control Management
* **Role-Based Auth:** Secure login console utilizing Supabase Auth, checking credentials and restricting access to Admin/Super Admin accounts.
* **Super Admin Controls:** Ability to register new admin panel accounts.
* **User Monitoring:** Analytics dashboard showing registered user statistics, active rates, and overall community metrics.

### 2. Garbage Collection Schedule Management
* **Schedule Templates:** Setup templates designating province, district, local authority, and recurring pickup days.
* **Calendar Planner:** Create, read, update, and delete individual collection events.
* **Status Updates:** Modify event progress flags (scheduled, in_progress, completed, cancelled).

### 3. Illegal Dumping Reports Console
* **Real-time Map Placements:** View submitted report pins placed on an interactive map.
* **Image Inspections:** Review site photographs uploaded by users.
* **Analytics Review:** View identified objects and proportions calculated by the companion classification model.
* **Resolution Pipeline:** Track status transitions from pending to investigating and resolved.

### 4. Educational Content & Quiz Management
* **Article Publisher:** Rich editor to publish and categorize environmental awareness articles.
* **Kids Corner Manager:** Panel to add/edit kids' quiz items, choices, and answers.
* **Media Uploads:** Link article cards to corresponding graphic assets.

### 5. Communications & Feedback Channels
* **System Broadcaster:** Push notifications with category tags (general, pickup, urgent, announcement) and priorities (1-5).
* **Feedback Manager:** Monitor user-submitted complaints, bug reports, and feedback, with text input to send replies.

---

## ⚙️ Installation & Setup

### Prerequisites
* **Flutter SDK** (^3.32.5)
* **Dart SDK** (^3.5.0)
* **Google Chrome** (for web development and testing)

---

### Step 1: Database Initialization

1. Configure the core database using the main schema definition script in the Mobile Application project: `database/schema.sql`.
2. Configure the admin-specific auth tables using the dashboard script located in:
   * **[database/database_schema.sql](database/database_schema.sql)**

---

### Step 2: Set up the Web Dashboard

1. Get package dependencies:
   ```bash
   flutter pub get
   ```

2. Create a `.env` file in your root folder:
   ```env
   SUPABASE_URL=https://your-project.supabase.co
   SUPABASE_ANON_KEY=your-anon-key
   ```

3. Run the development server:
   ```bash
   flutter run -d chrome --web-renderer html
   ```

---

## 🔧 Configuration

### Environment Setup
The application currently runs in standalone mode with mock data. For production, connect it to Supabase using:
* Option A (Recommended): The environment variables in `.env` (handled at build time).
* Option B: Hardcoding credentials directly in your service initialization:
  ```dart
  const String SUPABASE_URL = 'your-supabase-url';
  const String SUPABASE_ANON_KEY = 'your-anon-key';
  ```

---

## 📱 Responsive Design

The admin panel is fully responsive and works on:
* **Desktop:** Full dashboard with sidebar navigation
* **Tablet:** Optimized layout with collapsible sidebar
* **Mobile:** Touch-friendly interface with bottom navigation

---

## 🔒 Security Features

* **Role-based Access Control** (RBAC) restrict unauthorized users.
* **Secure Authentication** with session management.
* **Input Validation** and sanitization.
* **XSS Protection** for user-generated content.
* **CSRF Protection** for forms.

---

## 🌍 Notification System Integration

The admin panel is designed to work with the ReGen app's notification service, supporting the following types:
* `general` - Default notifications
* `pickup` - Waste pickup related
* `urgent` - High priority alerts
* `announcement` - Official announcements

---

## 🚀 How to Run the Application

### Running Local Development Debug:
```bash
flutter run -d chrome
```

### Building Production Release Bundle:
```bash
flutter build web --release --web-renderer canvaskit
```

---

## 📄 Project Resources
* **Abstract:** View our [Project Abstract](docs/Regen-Abstract.jpg)
* **Project Poster:** View our [Project Poster](docs/Regen%20-%20Project%20Poster.jpg)

---

## 📄 License
This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

Last Updated: July 2025
