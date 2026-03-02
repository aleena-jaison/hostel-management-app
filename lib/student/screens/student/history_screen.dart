import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Dummy Data (Replace with Firebase later)
  final List<Map<String, dynamic>> historyData = [
    {
      "type": "attendance",
      "title": "Entry Recorded",
      "date": "22 Feb 2026",
      "time": "08:45 AM",
      "verified": true
    },
    {
      "type": "attendance",
      "title": "Exit Recorded",
      "date": "22 Feb 2026",
      "time": "05:30 PM",
      "verified": true
    },
    {
      "type": "gatepass",
      "title": "Gate Pass Approved",
      "date": "21 Feb 2026",
      "time": "03:00 PM",
      "status": "approved"
    },
    {
      "type": "gatepass",
      "title": "Gate Pass Pending",
      "date": "20 Feb 2026",
      "time": "01:00 PM",
      "status": "pending"
    },
    {
      "type": "sos",
      "title": "SOS Triggered",
      "date": "18 Feb 2026",
      "time": "09:15 PM",
      "status": "resolved"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: const Color(0xFF0B1220),
  body: Column(
    children: [
      const SizedBox(height: 10), // very small spacing (optional)

      TabBar(
        controller: _tabController,
        indicatorColor: Colors.blue,
        labelColor: Colors.blue,
        unselectedLabelColor: Colors.grey,
        tabs: const [
          Tab(text: "All"),
          Tab(text: "Attendance"),
          Tab(text: "Gate Pass"),
          Tab(text: "SOS"),
        ],
      ),

      Expanded(
        child: TabBarView(
          controller: _tabController,
          children: [
            buildList("all"),
            buildList("attendance"),
            buildList("gatepass"),
            buildList("sos"),
          ],
        ),
      ),
    ],
  ),
);
  }

  Widget buildList(String filterType) {
    final filteredData = filterType == "all"
        ? historyData
        : historyData.where((item) => item["type"] == filterType).toList();

    if (filteredData.isEmpty) {
      return const Center(
        child: Text(
          "No history available",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredData.length,
      itemBuilder: (context, index) {
        final item = filteredData[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: getColor(item).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  getIcon(item["type"]),
                  color: getColor(item),
                  size: 26,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item["title"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "${item["date"]} • ${item["time"]}",
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              if (item["type"] == "attendance")
                Icon(
                  item["verified"] ? Icons.verified : Icons.error,
                  color:
                      item["verified"] ? Colors.green : Colors.red,
                ),
            ],
          ),
        );
      },
    );
  }

  IconData getIcon(String type) {
    switch (type) {
      case "attendance":
        return Icons.login;
      case "gatepass":
        return Icons.card_membership;
      case "sos":
        return Icons.warning_amber_rounded;
      default:
        return Icons.history;
    }
  }

  Color getColor(Map<String, dynamic> item) {
    if (item["type"] == "attendance") {
      return item["title"].contains("Entry")
          ? Colors.green
          : Colors.red;
    }
    if (item["type"] == "gatepass") {
      if (item["status"] == "approved") return Colors.blue;
      if (item["status"] == "pending") return Colors.orange;
      return Colors.red;
    }
    if (item["type"] == "sos") {
      return Colors.red;
    }
    return Colors.grey;
  }
}