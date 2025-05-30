import 'package:flutter/material.dart';
import 'newspage.dart';
import 'messagepage.dart';
import 'dart:async';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFe8f5f0),

      // ✅ Drawer Sidebar
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1f4037), Color(0xFF99f2c8)],
                ),
              ),
              child: Row(
                children: const [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'assets/images/profile.jpg',
                    ), // Replace with actual image path
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Welcome, User!",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.newspaper),
              title: const Text("News"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Newspage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: const Text("Plan"),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to Plan Page
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Settings"),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navigate to Settings Page
              },
            ),
          ],
        ),
      ),

      // ✅ App Bar
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1f4037), Color(0xFF99f2c8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  // Hamburger Menu Button
                  Builder(
                    builder: (context) => InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Center Title
                  const Text(
                    "Hello, User",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const Spacer(),

                  // Message Icon Button
                  InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const MessagesPage()),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.message_rounded,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      // ✅ Main Body (make the whole page scrollable)
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ImageCarousel(),
            AboutSection(),
            PremiumPlansSection(),
            ContactSection(), // <-- Add this line
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// Add this widget below your DashboardPage class
class ImageCarousel extends StatefulWidget {
  const ImageCarousel({super.key});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final PageController _controller = PageController();
  final List<String> _images = [
    'img1.jpg',
    'img1.jpg',
    'img1.jpg',
    'img1.jpg',
    'img1.jpg',
  ];
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double carouselHeight =
        MediaQuery.of(context).size.height * 0.35; // Slightly reduced height
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: carouselHeight,
          width: double.infinity,
          child: PageView.builder(
            controller: _controller,
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ), // No vertical padding
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    _images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_images.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 16 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? Colors.greenAccent
                    : const Color.fromARGB(255, 135, 199, 164),
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive max width for large screens
    final double maxWidth =
        MediaQuery.of(context).size.width > 600 ? 600 : double.infinity;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 12), // Reduced padding
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding:
                  const EdgeInsets.all(16), // Slightly reduced inner padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "About Stock Trade",
                    style: TextStyle(
                      fontSize: 25, // Slightly smaller
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1f4037),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "We at StockTrade provide accurate and timely stock market analysis to help users make informed investment decisions. Our platform offers free as well as premium stock market tips, ensuring that both beginners and experienced traders get the best insights. Whether you're looking for short-term trading opportunities or long-term investments, our expert guidance is designed to maximize your returns. Join us today and start trading with confidence!",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
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

class PremiumPlansSection extends StatelessWidget {
  const PremiumPlansSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double maxWidth =
        MediaQuery.of(context).size.width > 900 ? 900 : double.infinity;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Premium Plans",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1f4037),
                ),
              ),
              const SizedBox(height: 16),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 700;
                  return Flex(
                    direction: isWide ? Axis.horizontal : Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _PlanCard(
                        icon: Icons.star_border,
                        title: "Basic Plan",
                        subtitle: "Premium plan for Free",
                        description:
                            "Get proper stock market tips and analysis",
                        price: "Free",
                        buttonColor: Colors.greenAccent.shade700,
                        onPressed: () {},
                      ),
                      if (isWide)
                        const SizedBox(width: 18)
                      else
                        const SizedBox(height: 18),
                      _PlanCard(
                        icon: Icons.trending_up,
                        title: "Standard Plan",
                        subtitle: "Premium plan for one month",
                        description: "Get accurate stock market insights",
                        price: "₹499 / month",
                        buttonColor: Colors.blueAccent,
                        onPressed: () {},
                      ),
                      if (isWide)
                        const SizedBox(width: 18)
                      else
                        const SizedBox(height: 18),
                      _PlanCard(
                        icon: Icons.workspace_premium,
                        title: "Premium Plan",
                        subtitle: "Premium plan for three months",
                        description: "Advanced stock trading analysis",
                        price: "₹1299 / 3 months",
                        buttonColor: Colors.deepPurple,
                        onPressed: () {},
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final String price;
  final Color buttonColor;
  final VoidCallback onPressed;

  const _PlanCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320, // Set a max width for cards on wide screens
      constraints: const BoxConstraints(minWidth: 220, maxWidth: 400),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: buttonColor.withOpacity(0.12),
                child: Icon(icon, size: 32, color: buttonColor),
              ),
              const SizedBox(height: 14),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: buttonColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                description,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                price,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: buttonColor,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: onPressed,
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Responsive max width for large screens
    final double maxWidth =
        MediaQuery.of(context).size.width > 600 ? 600 : double.infinity;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 12), // Reduced padding
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Card(
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding:
                  const EdgeInsets.all(16), // Slightly reduced inner padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: 25, // Slightly smaller
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1f4037),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "For any inquiries, suggestions, or feedback, feel free to reach out to us. We're here to help you!",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Email: support@stocktrade.com",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Phone: +91 123 456 7890",
                    style: TextStyle(fontSize: 15, color: Colors.black87),
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
