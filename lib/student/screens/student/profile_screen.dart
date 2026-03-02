import 'package:flutter/material.dart';

enum UserRole { student, warden, admin }

class ProfileScreen extends StatefulWidget {
  final bool isEditing;

  const ProfileScreen({super.key, required this.isEditing});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserRole currentRole = UserRole.student;

  bool get isStudent => currentRole == UserRole.student;

  final TextEditingController nameController =
      TextEditingController(text: "Arsha V A");
  final TextEditingController emailController =
      TextEditingController(text: "arsha@email.com");
  final TextEditingController phoneController =
      TextEditingController(text: "9876543210");

  final TextEditingController admissionController =
      TextEditingController(text: "S12345");
  final TextEditingController deptController =
      TextEditingController(text: "Computer Science");
  final TextEditingController yearController =
      TextEditingController(text: "3");
  final TextEditingController blockController =
      TextEditingController(text: "Block A");
  final TextEditingController roomController =
      TextEditingController(text: "205");

  final TextEditingController parentNameController =
      TextEditingController(text: "Father Name");
  final TextEditingController parentPhoneController =
      TextEditingController(text: "9999999999");

  final TextEditingController bloodGroupController =
      TextEditingController(text: "O+");
  final TextEditingController medicalController =
      TextEditingController(text: "None");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0B1220),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCard("Basic Info", [
              _buildField("Name", nameController,
                  enabled: widget.isEditing),
              _buildField("Email", emailController, enabled: false),
              _buildField("Phone", phoneController,
                  enabled: widget.isEditing),
            ]),
            _buildCard("Academic & Hostel Info", [
              _buildField("Admission No", admissionController,
                  enabled: widget.isEditing && !isStudent,
                  locked: isStudent),
              _buildField("Department", deptController,
                  enabled: widget.isEditing && !isStudent,
                  locked: isStudent),
              _buildField("Year", yearController,
                  enabled: widget.isEditing && !isStudent,
                  locked: isStudent),
              _buildField("Block", blockController,
                  enabled: widget.isEditing && !isStudent,
                  locked: isStudent),
              _buildField("Room", roomController,
                  enabled: widget.isEditing && !isStudent,
                  locked: isStudent),
            ]),
            _buildCard("Emergency Contact", [
              _buildField("Parent Name", parentNameController,
                  enabled: widget.isEditing),
              _buildField("Parent Phone", parentPhoneController,
                  enabled: widget.isEditing),
            ]),
            _buildCard("Medical Info", [
              _buildField("Blood Group", bloodGroupController,
                  enabled: widget.isEditing),
              _buildField("Medical Conditions", medicalController,
                  enabled: widget.isEditing),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String title, List<Widget> children) {
    return Card(
      color: const Color(0xFF111827),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...children
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller,
      {required bool enabled, bool locked = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        enabled: enabled,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey),
          suffixIcon:
              locked ? const Icon(Icons.lock, color: Colors.grey) : null,
          filled: true,
          fillColor: const Color(0xFF1F2937),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}