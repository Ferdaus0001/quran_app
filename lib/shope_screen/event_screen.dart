import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/shope_screen/product_deatils_screen.dart';
import 'filter_screen.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  String selectedCategory = "All";

  // 🔹 EVENT DATA
  final List<Map<String, String>> events = [
    {
      "title": "Fashion Design Expo 2026",
      "category": "Workshop",
      "location": "Dhaka Convention Center",
      "date": "12 DEC",
      "price": "\$20"
    },
    {
      "title": "Music Concert Night",
      "category": "Concert",
      "location": "City Hall",
      "date": "20 JAN",
      "price": "\$50"
    },
    {
      "title": "Flutter Meetup",
      "category": "Meetup",
      "location": "Tech Hub",
      "date": "05 FEB",
      "price": "Free"
    },
    {
      "title": "Business Workshop",
      "category": "Workshop",
      "location": "Conference Center",
      "date": "18 MAR",
      "price": "\$30"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 🔥 FILTER
    List<Map<String, String>> filteredEvents =
    selectedCategory == "All"
        ? events
        : events
        .where((item) =>
    item["category"] == selectedCategory)
        .toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 CATEGORY + FILTER
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _categoryChip("All"),
                const SizedBox(width: 8),
                _categoryChip("Concert"),
                const SizedBox(width: 8),
                _categoryChip("Workshop"),
                const SizedBox(width: 8),
                _categoryChip("Meetup"),
                const SizedBox(width: 12),

                GestureDetector(
                  onTap: () {
                    Get.to(const FilterScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.filter_list),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 🔹 EVENT LIST (BIG CARDS)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredEvents.length,
            itemBuilder: (context, index) {
              final event = filteredEvents[index];
              return _eventCard(event);
            },
          ),
        ],
      ),
    );
  }

  // 🔴 CATEGORY CHIP
  Widget _categoryChip(String title) {
    final bool isSelected = selectedCategory == title;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },
      child: Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }

  // 🔴 EVENT CARD (LARGE UI)
  Widget _eventCard(Map<String, String> event) {
    return GestureDetector(
      onTap: () {
        Get.to(const ProductDetailScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 IMAGE + DATE BADGE
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(14)),
                  child: Image.network(
                    "https://tse1.mm.bing.net/th/id/OIP.cW0wzJYojHH-xxW35Wj7dQHaHa",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          event["date"]!.split(" ")[0],
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          event["date"]!.split(" ")[1],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // 🔹 DETAILS
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.event,
                          color: Colors.purple, size: 20),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          event["title"]!,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(
                        event["location"]!,
                        style: const TextStyle(
                            fontSize: 13, color: Colors.grey),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        event["price"]!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                          fontSize: 16,
                        ),
                      ),
                      const Text(
                        "View Details",
                        style: TextStyle(
                            color: Colors.purple, fontSize: 13),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}