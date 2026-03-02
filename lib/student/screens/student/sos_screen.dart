import 'package:flutter/material.dart';
import 'dart:async';

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen>
    with SingleTickerProviderStateMixin {
  bool isSosActive = false;
  bool isProcessing = false;
  List<String> steps = [];
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 0.9,
      upperBound: 1.1,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> activateSOS() async {
    setState(() {
      isProcessing = true;
      steps.clear();
    });

    List<String> emergencySteps = [
      "Alerting Warden...",
      "Alerting Parent...",
      "Notifying Security...",
      "Fetching Live Location...",
      "Sharing Location..."
    ];

    for (String step in emergencySteps) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        steps.add(step);
      });
    }

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isProcessing = false;
      isSosActive = true;
    });
  }

  void stopSOS() {
    setState(() {
      isSosActive = false;
      steps.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Emergency Stopped")),
    );
  }

  /// 🔥 NEW: Clean state-based UI builder
  Widget _buildContent() {
    // PROCESSING STATE
    if (isProcessing) {
      return Column(
        key: const ValueKey("processing"),
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          ...steps.map(
            (step) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle,
                      color: Colors.redAccent),
                  const SizedBox(width: 10),
                  Text(
                    step,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    // ACTIVE STATE
    if (isSosActive) {
      return Column(
        key: const ValueKey("active"),
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.warning_rounded,
              color: Colors.red, size: 90),
          const SizedBox(height: 20),
          const Text(
            "Emergency Active",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: stopSOS,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: const Text("STOP SOS"),
          ),
        ],
      );
    }

    // NORMAL STATE
    return Column(
      key: const ValueKey("normal"),
      mainAxisSize: MainAxisSize.min,
      children: [
        ScaleTransition(
          scale: _pulseController,
          child: GestureDetector(
            onLongPress: activateSOS,
            child: Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.6),
                    blurRadius: 30,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: const Center(
                child: Text(
                  "SOS",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Long press to activate emergency",
          style: TextStyle(color: Colors.white70),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B1220),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text("Emergency SOS"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: _buildContent(),
            ),
          ),
        ),
      ),
    );
  }
}