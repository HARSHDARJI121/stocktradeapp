import 'package:flutter/material.dart';
import 'AllUsersPage.dart';
import 'PremiumUsersPage.dart';
import 'messagepage.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
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

  // News management
  final List<Map<String, String>> _newsList = [];
  final TextEditingController _newsController = TextEditingController();
  int? _editingIndex;

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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const MessagesPage(group: "all")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium, color: Colors.deepPurple),
            title: const Text("Premium Users Group"),
            subtitle: const Text("Only premium members"),
            onTap: () {
              Navigator.pop(context);
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

  void _showNewsDialog({int? editIndex}) {
    if (editIndex != null) {
      _newsController.text = _newsList[editIndex]['text'] ?? '';
    } else {
      _newsController.clear();
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(editIndex == null ? "Post News" : "Edit News"),
        content: TextField(
          controller: _newsController,
          maxLines: 3,
          decoration: const InputDecoration(
            hintText: "Enter news to post...",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              _newsController.clear();
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (editIndex == null) {
                  _newsList.insert(0, {
                    "text": _newsController.text,
                    "date": DateTime.now().toString().substring(0, 16)
                  });
                } else {
                  _newsList[editIndex]['text'] = _newsController.text;
                }
              });
              _newsController.clear();
              Navigator.pop(context);
            },
            child: Text(editIndex == null ? "Post" : "Save"),
          ),
        ],
      ),
    );
  }

  void _deleteNews(int index) {
    setState(() {
      _newsList.removeAt(index);
    });
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
        backgroundColor: Colors.blueGrey[900],
        actions: [
          IconButton(
            icon: const Icon(Icons.message_rounded, color: Colors.white),
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
            colors: [Color(0xFFe3eafc), Color(0xFFb6c8f9)],
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
                      color: Colors.blueGrey,
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
                        color: Colors.blue,
                        glowColor: Colors.blue.withOpacity(0.3),
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
                  const SizedBox(height: 48),
                  // News Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "News Board",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(Icons.add),
                        label: const Text("Post News"),
                        onPressed: () => _showNewsDialog(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _newsList.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Text(
                            "No news posted yet.",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _newsList.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final news = _newsList[index];
                            return Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: ListTile(
                                title: Text(
                                  news["text"] ?? "",
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  "Posted: ${news["date"]}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit, color: Colors.blue),
                                      tooltip: "Edit",
                                      onPressed: () => _showNewsDialog(editIndex: index),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete, color: Colors.red),
                                      tooltip: "Delete",
                                      onPressed: () => _deleteNews(index),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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