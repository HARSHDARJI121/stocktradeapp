import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TransactionPage extends StatelessWidget {
  final String plan;
  final String amount;
  final String userName;
  final String userEmail;

  const TransactionPage({
    super.key,
    required this.plan,
    required this.amount,
    required this.userName,
    required this.userEmail,
  });

  @override
  Widget build(BuildContext context) {
    const phoneNumber = "+919320928936"; // Replace with actual phone number

    return Scaffold(
      appBar: AppBar(
        title: const Text("Complete Your Payment"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxWidth: 420),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Complete Your Payment",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2c3e50),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Text(
                  'Plan: "$plan"',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  'Amount: "₹$amount"',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                // QR Code Image (replace with your asset)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/scanner.png', // Place your QR code image here
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  "Scan the QR Code to complete your payment.",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Color(0xFFe0f7fa),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    "Once the payment is done, click on the button below and send the message along with the payment screenshot.",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: Image.network(
                    "data:image/jpeg;base64,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",
                    width: 24,
                    height: 24,
                  ),
                  label: const Text(
                    "Send to WhatsApp",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {
                    final message =
                        "Hi, I have completed the payment for the plan: $plan. Here is the payment screenshot.";
                    final whatsappUrl =
                        "https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}";
                    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
                      await launchUrl(Uri.parse(whatsappUrl), mode: LaunchMode.externalApplication);
                    }
                  },
                ),
                const SizedBox(height: 18),
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.blueGrey[900],
                    side: BorderSide(color: Colors.blueGrey[900]!),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 28),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: const Text(
                    "Go Back",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}