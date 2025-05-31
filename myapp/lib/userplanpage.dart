import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserPlanPage extends StatelessWidget {
  const UserPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy user data (replace with dynamic values)
    const String userName = "Harsh Darji";
    const String email = "darjiharsh2005@gmail.com";
    const String plan = "standard";
    const String amount = "₹1251";
    const String startDateStr = "5/15/2025";
    const String endDateStr = "6/14/2025";
    const String status = "accepted";

    // Parse dates
    final DateFormat formatter = DateFormat('M/d/yyyy');
    final DateTime endDate = formatter.parse(endDateStr);
    final bool isExpired = DateTime.now().isAfter(endDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Premium Plan"),
        backgroundColor: const Color(0xFF1f4037),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1f4037), Color(0xFF99f2c8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome, $userName 🎉",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Email: $email",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "YOUR ACCEPTED TRANSACTIONS 💰",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Active plan card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Plan: standard", style: TextStyle(color: Colors.white)),
                        const Text("Amount: ₹1251", style: TextStyle(color: Colors.white)),
                        Text("Start Date: $startDateStr", style: const TextStyle(color: Colors.white)),
                        Text("End Date: $endDateStr", style: const TextStyle(color: Colors.white)),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            minHeight: 12,
                            value: isExpired ? 0.0 : 0.6,
                            backgroundColor: Colors.black26,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isExpired ? Colors.red : Colors.lightGreenAccent,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "STATUS: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                color: isExpired ? Colors.red : Colors.blue[300],
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
