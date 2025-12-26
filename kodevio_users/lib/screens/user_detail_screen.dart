import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final UserModel user;

  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,

      //Bug Fix: StatusBar icons readability

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade800,
              Colors.blue.shade100,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 100),

              //  Top Animated Profile Header

              _buildHeader(),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    // 📱 Contact Info Card
                    _buildAnimatedCard(
                      index: 1,
                      title: "Contact Information",
                      icon: Icons.alternate_email_rounded,
                      color: Colors.orangeAccent,
                      items: [
                        _buildDetailItem(Icons.person_outline, "Username", user.username, Colors.orange),
                        _buildDetailItem(Icons.email_outlined, "Email", user.email, Colors.redAccent),
                        _buildDetailItem(Icons.phone_iphone, "Phone", user.phone, Colors.blue),
                        _buildDetailItem(Icons.public, "Website", user.website, Colors.teal),
                      ],
                    ),

                    const SizedBox(height: 20),

                    //  Location & Work Card

                    _buildAnimatedCard(
                      index: 2,
                      title: "Address & Company",
                      icon: Icons.location_on_rounded,
                      color: Colors.pinkAccent,
                      items: [
                        _buildDetailItem(Icons.map_rounded, "Address", user.address.fullAddress, Colors.pink),
                        _buildDetailItem(Icons.business_center_rounded, "Company", user.company.name, Colors.indigo),
                        _buildDetailItem(Icons.auto_awesome_rounded, "Catchphrase", user.company.catchPhrase, Colors.deepPurple),
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Profile Header Section

  Widget _buildHeader() {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 800),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutBack,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: value,
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10)
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      user.name.isNotEmpty ? user.name.substring(0, 1).toUpperCase() : "?",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.w900, color: Colors.deepPurple.shade700),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Text(
                  "@${user.username}",
                  style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8), letterSpacing: 1.2),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Animated Card Builder

  Widget _buildAnimatedCard({
    required int index,
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> items,
  }) {
    return TweenAnimationBuilder(
      duration: Duration(milliseconds: 600 + (index * 200)),
      tween: Tween<double>(begin: 0, end: 1),
      curve: Curves.easeOutCubic,
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF2D3142)),
                ),
              ],
            ),
            const Divider(height: 30, thickness: 0.5),
            ...items,
          ],
        ),
      ),
    );
  }

  // Individual Info Row

  Widget _buildDetailItem(IconData icon, String label, String value, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),

          // Flexible used to prevent overflow for long addresses

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF2D3142),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}