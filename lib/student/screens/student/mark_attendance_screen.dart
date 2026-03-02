import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:intl/intl.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  String status = "Not Marked";
  String timeMarked = "--";
  bool isLoading = false;
  String errorMessage = "";

  Future<void> authenticate() async {
    setState(() {
      status = "Present";
      timeMarked = DateFormat('hh:mm a').format(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    String today = DateFormat('dd MMM yyyy').format(DateTime.now());

    Color cardColor = status == "Present" ? Colors.green : Colors.orange;

    return Scaffold(
      appBar: AppBar(title: const Text("Mark Attendance"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            /// 🔥 HERO STATUS CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: cardColor,
              ),
              child: Column(
                children: [
                  Text(today, style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 10),
                  Text(
                    status,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Time: $timeMarked",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            const Icon(Icons.fingerprint, size: 90, color: Colors.blueGrey),

            const SizedBox(height: 20),

            const Text(
              "Verify your identity to mark today's attendance",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),

            const Spacer(),

            /// 🔐 BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : authenticate,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Verify & Mark Attendance",
                        style: TextStyle(fontSize: 16),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
