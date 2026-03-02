import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GatePassScreen extends StatefulWidget {
  const GatePassScreen({super.key});

  @override
  State<GatePassScreen> createState() => _GatePassScreenState();
}

class _GatePassScreenState extends State<GatePassScreen> {
  final TextEditingController reasonController = TextEditingController();

  DateTime? outDate;
  TimeOfDay? outTime;
  DateTime? returnDate;
  TimeOfDay? returnTime;

  String status = "No Request";

  Future<void> pickDate(bool isOut) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isOut) {
          outDate = picked;
        } else {
          returnDate = picked;
        }
      });
    }
  }

  Future<void> pickTime(bool isOut) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        if (isOut) {
          outTime = picked;
        } else {
          returnTime = picked;
        }
      });
    }
  }

  void submitRequest() {
    if (reasonController.text.isEmpty ||
        outDate == null ||
        outTime == null ||
        returnDate == null ||
        returnTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    setState(() {
      status = "Pending";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Gate Pass Request Sent")),
    );
  }

  Widget buildDateTimeTile({
    required String value,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF1F2937),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case "Pending":
        statusColor = Colors.orange;
        break;
      case "Approved":
        statusColor = Colors.green;
        break;
      case "Rejected":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          /// STATUS CARD
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: statusColor,
            ),
            child: Column(
              children: [
                const Text(
                  "Current Status",
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                Text(
                  status,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// FORM CARD
          Card(
            color: const Color(0xFF111827),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: reasonController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: "Reason",
                      labelStyle: TextStyle(color: Colors.white70),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white24),
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),

                  buildDateTimeTile(
                    value: outDate == null
                        ? "Select Out Date"
                        : DateFormat('dd MMM yyyy').format(outDate!),
                    icon: Icons.calendar_today,
                    onTap: () => pickDate(true),
                  ),

                  const SizedBox(height: 15),

                  buildDateTimeTile(
                    value: outTime == null
                        ? "Select Out Time"
                        : outTime!.format(context),
                    icon: Icons.access_time,
                    onTap: () => pickTime(true),
                  ),

                  const SizedBox(height: 20),

                  buildDateTimeTile(
                    value: returnDate == null
                        ? "Select Return Date"
                        : DateFormat('dd MMM yyyy').format(returnDate!),
                    icon: Icons.calendar_today,
                    onTap: () => pickDate(false),
                  ),

                  const SizedBox(height: 15),

                  buildDateTimeTile(
                    value: returnTime == null
                        ? "Select Return Time"
                        : returnTime!.format(context),
                    icon: Icons.access_time,
                    onTap: () => pickTime(false),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: submitRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "Submit Gate Pass Request",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}