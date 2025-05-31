import 'package:flutter/material.dart';

class PremiumUsersPage extends StatelessWidget {
  final List<Map<String, String>> premiumUsers;

  const PremiumUsersPage({super.key, required this.premiumUsers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Premium Users"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: premiumUsers.length,
        itemBuilder: (context, index) {
          final user = premiumUsers[index];
          return ListTile(
            leading: const Icon(Icons.workspace_premium, color: Colors.deepPurple),
            title: Text(user['name'] ?? ""),
            subtitle: Text(user['email'] ?? ""),
          );
        },
      ),
    );
  }
}
