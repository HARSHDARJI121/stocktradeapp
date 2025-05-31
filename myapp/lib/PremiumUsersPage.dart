import 'package:flutter/material.dart';

class PremiumUsersPage extends StatefulWidget {
  final List<Map<String, String>> premiumUsers;

  const PremiumUsersPage({super.key, required this.premiumUsers});

  @override
  State<PremiumUsersPage> createState() => _PremiumUsersPageState();
}

class _PremiumUsersPageState extends State<PremiumUsersPage> {
  late List<Map<String, String>> _premiumUsers;

  @override
  void initState() {
    super.initState();
    _premiumUsers = List<Map<String, String>>.from(widget.premiumUsers);
  }

  void _removeUser(int index) {
    setState(() {
      _premiumUsers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Premium Users"),
        backgroundColor: Colors.deepPurple,
      ),
      body: _premiumUsers.isEmpty
          ? const Center(
              child: Text(
                "No premium users.",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _premiumUsers.length,
              itemBuilder: (context, index) {
                final user = _premiumUsers[index];
                return ListTile(
                  leading: const Icon(Icons.workspace_premium, color: Colors.deepPurple),
                  title: Text(user['name'] ?? ""),
                  subtitle: Text(user['email'] ?? ""),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: "Remove from Premium",
                    onPressed: () => _removeUser(index),
                  ),
                );
              },
            ),
    );
  }
}