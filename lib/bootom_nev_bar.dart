import 'package:flutter/material.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const ShopScreen(),
    const AddScreen(),
    const ConnectScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[currentIndex],           // এখানে স্ক্রিন চেঞ্জ হয়
      
        bottomNavigationBar: Container(
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey, width: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home
              _navItem(Icons.home_outlined, "Home", 0),
              // Shop
              _navItem(Icons.shopping_bag_outlined, "Shop", 1),
      
              // Big Center Red Button
              GestureDetector(
                onTap: () => setState(() => currentIndex = 2),
                child: Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFEF4444).withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.add, color: Colors.white, size: 36),
                ),
              ),
      
              // Connect
              _navItem(Icons.favorite_border, "Connect", 3),
              // Account
              _navItem(Icons.person_outline, "Account", 4),
            ],
          ),
        ),
      ),
    );
  }

  // ছোট Nav Item
  Widget _navItem(IconData icon, String label, int index) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => setState(() => currentIndex = index),
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26,
              color: isSelected ? const Color(0xFFEF4444) : Colors.black87,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFFEF4444) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================== Dummy Screens (পরে তোমার নিজের স্ক্রিন দিয়ে replace করবে) ==================

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("🏠 Home Screen", style: TextStyle(fontSize: 28)));
  }
}

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("🛍️ Shop Screen", style: TextStyle(fontSize: 28)));
  }
}

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("➕ Add New Screen", style: TextStyle(fontSize: 28)));
  }
}

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("❤️ Connect Screen", style: TextStyle(fontSize: 28)));
  }
}

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("👤 Account Screen", style: TextStyle(fontSize: 28)));
  }
}