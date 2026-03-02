import 'package:flutter/material.dart';
import '../../widgets/quick_action_card.dart';
import '../../widgets/stat_card.dart';
import 'mark_attendance_screen.dart';
import 'gate_pass_screen.dart';
import 'sos_screen.dart';
import 'profile_screen.dart';
import 'history_screen.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int currentIndex = 0;
  bool isEditingProfile = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xFF0B1220),

      /// 🔹 Clean AppBar
      appBar: AppBar(
        backgroundColor:const Color(0xFF0B1220),
        elevation: 0.5,
        automaticallyImplyLeading: false,
        title: _buildAppBarTitle(),
        actions: [
          if (currentIndex == 0)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                },
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFF2563EB),
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
            ),
          if (currentIndex == 3)
            IconButton(
              icon: Icon(
                isEditingProfile ? Icons.check : Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isEditingProfile = !isEditingProfile;
                });
              },
            ),
        ],
      ),

      body: SafeArea(child: _buildBody()),

      /// 🔹 Minimal Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        backgroundColor:const Color(0xFF0B1220),
        elevation: 8,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_rounded),
            label: "Pass",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_rounded),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarTitle() {
    switch (currentIndex) {
      case 0:
        return const Text(
          "Dashboard",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
      case 1:
        return const Text("Gate Pass",
            style: TextStyle(color: Colors.white));
      case 2:
        return const Text("History",
            style: TextStyle(color: Colors.white));
      case 3:
        return const Text("My Profile",
            style: TextStyle(color: Colors.white));
      default:
        return const Text("Dashboard",
            style: TextStyle(color: Colors.white));
    }
  }

  Widget _buildBody() {
    switch (currentIndex) {
      case 0:
        return _dashboardHome();
      case 1:
        return const GatePassScreen();
      case 2:
        return const HistoryScreen();
      case 3:
        return ProfileScreen(isEditing: isEditingProfile);
      default:
        return _dashboardHome();
    }
  }

  Widget _dashboardHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StatCard(),
          const SizedBox(height: 30),

          const Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 20),

          QuickActionCard(
            title: "Mark Attendance",
            icon: Icons.check_circle_outline,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MarkAttendanceScreen(),
                ),
              );
            },
          ),

          const SizedBox(height: 16),

          QuickActionCard(
            title: "Emergency SOS",
            icon: Icons.warning_amber_outlined,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SosScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}