import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AllUsersPage.dart';
import 'PremiumUsersPage.dart';
import 'messagepage.dart'; // <-- Import your MessagesPage

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  // Dummy user lists for demonstration
  List<Map<String, String>> get allUsers => [
        {"name": "Harsh Darji", "email": "darjiharsh2005@gmail.com"},
        {"name": "Amit Patel", "email": "amitpatel@gmail.com"},
        {"name": "Priya Shah", "email": "priyashah@gmail.com"},
        {"name": "Ravi Kumar", "email": "ravikumar@gmail.com"},
      ];

  List<Map<String, String>> get premiumUsers => [
        {"name": "Harsh Darji", "email": "darjiharsh2005@gmail.com"},
        {"name": "Priya Shah", "email": "priyashah@gmail.com"},
      ];

  void _showUserList(BuildContext context, String title,
      List<Map<String, String>> users, Color color) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.15),
                blurRadius: 18,
                spreadRadius: 2,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              const Divider(thickness: 1.2),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: color.withOpacity(0.15),
                        child: Icon(Icons.person, color: color),
                      ),
                      title: Text(user["name"] ?? "",
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(user["email"] ?? ""),
                      trailing: title == "Premium Users"
                          ? const Icon(Icons.workspace_premium,
                              color: Colors.deepPurple)
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGroupSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.group, color: Colors.blueAccent),
            title: const Text("All Users Group"),
            subtitle: const Text("Everyone in StockTrade"),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to all users group chat
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const MessagesPage(group: "all")),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.workspace_premium, color: Colors.deepPurple),
            title: const Text("Premium Users Group"),
            subtitle: const Text("Only premium members"),
            onTap: () {
              Navigator.pop(context);
              // TODO: Navigate to premium users group chat
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const MessagesPage(group: "premium")),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        backgroundColor: const Color(0xFF1f4037),
        actions: [
          IconButton(
            icon: const Icon(Icons.message_rounded,
                color: Colors.white), // Always white
            tooltip: "StockTrade Group Calls",
            onPressed: () => _showGroupSheet(context),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Logout",
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
        elevation: 4,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1f4037), Color(0xFF99f2c8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome, Admin!",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1f4037),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 40,
                    runSpacing: 32,
                    alignment: WrapAlignment.center,
                    children: [
                      _DashboardCircle(
                        icon: Icons.people,
                        label: "All Users",
                        color: Colors.blueAccent,
                        glowColor: Colors.blueAccent.withOpacity(0.3),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AllUsersPage(allUsers: allUsers),
                            ),
                          );
                        },
                      ),
                      _DashboardCircle(
                        icon: Icons.workspace_premium,
                        label: "Premium Users",
                        color: Colors.deepPurple,
                        glowColor: Colors.deepPurple.withOpacity(0.3),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  PremiumUsersPage(premiumUsers: premiumUsers),
                            ),
                          );
                        },
                      ),
                    ],
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

class _DashboardCircle extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color glowColor;
  final VoidCallback onTap;

  const _DashboardCircle({
    required this.icon,
    required this.label,
    required this.color,
    required this.glowColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(80),
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.13),
              border: Border.all(color: color, width: 5),
              boxShadow: [
                BoxShadow(
                  color: glowColor,
                  blurRadius: 32,
                  spreadRadius: 6,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Icon(icon, size: 60, color: color),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 20,
              letterSpacing: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
