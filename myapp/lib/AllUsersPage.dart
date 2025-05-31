import 'package:flutter/material.dart';

class AllUsersPage extends StatelessWidget {
  final List<Map<String, String>> allUsers;

  const AllUsersPage({super.key, required this.allUsers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: allUsers.length,
        itemBuilder: (context, index) {
          final user = allUsers[index];
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(user['name'] ?? ""),
            subtitle: Text(user['email'] ?? ""),
          );
        },
      ),
    );
  }
}
