import 'package:flutter/material.dart';
import 'ProductsScreen.dart';
import 'ServicesScreen.dart';
import 'job_screen.dart';
import 'event_screen.dart';

class ShopeScreen extends StatefulWidget {
  const ShopeScreen({super.key});

  @override
  State<ShopeScreen> createState() => _ShopeScreenState();
}

class _ShopeScreenState extends State<ShopeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> tabsData = [
    {"title": "Products", "icon": Icons.shopping_bag},
    {"title": "Services", "icon": Icons.build_outlined},
    {"title": "Jobs", "icon": Icons.work_outline},
    {"title": "Events", "icon": Icons.event_note},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabsData.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildTab(int index) {
    final isSelected = _tabController.index == index;

    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              tabsData[index]["icon"],
              size: 18,
              color: isSelected ? Colors.black : Colors.grey,
            ),
            const SizedBox(width: 6),
            Text(
              tabsData[index]["title"],
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Search products, services, jobs & events",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),

      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: const TextField(
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: "Search products, services, jobs...",
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 12,
                  ),
                ),
              ),
            ),
          ),

          // 🔥 SEGMENTED TABS CONTAINER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    tabsData.length,
                        (index) => _buildTab(index),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // 🔥 TAB CONTENT
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                ProductsScreen(),
                ServicesScreen(),
                JobsScreen(),
                EventsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}