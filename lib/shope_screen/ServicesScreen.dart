import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/shope_screen/product_deatils_screen.dart';
import 'filter_screen.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  String selectedCategory = "All";

  final List<Map<String, String>> services = [
    {
      "title": "Jewelry Repair Service",
      "category": "Repair",
      "provider": "Expert Service Center",
      "price": "\$49",
      "rating": "4.8"
    },
    {
      "title": "Home Cleaning Service",
      "category": "Cleaning",
      "provider": "CleanPro Team",
      "price": "\$30",
      "rating": "4.6"
    },
    {
      "title": "Custom Jewelry Design",
      "category": "Custom Design",
      "provider": "Design Studio",
      "price": "\$99",
      "rating": "4.9"
    },
    {
      "title": "Mobile Repair Service",
      "category": "Repair",
      "provider": "Tech Fix Hub",
      "price": "\$25",
      "rating": "4.7"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 🔥 FILTER
    List<Map<String, String>> filteredServices =
    selectedCategory == "All"
        ? services
        : services
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
                _categoryChip("Repair"),
                const SizedBox(width: 8),
                _categoryChip("Cleaning"),
                const SizedBox(width: 8),
                _categoryChip("Custom Design"),
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

          // 🔹 LIST (BIG CARDS)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredServices.length,
            itemBuilder: (context, index) {
              final service = filteredServices[index];
              return _serviceCard(service);
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
          color: isSelected ? Colors.blue : Colors.grey[200],
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

  // 🔴 SERVICE CARD (BIG STYLE)
  Widget _serviceCard(Map<String, String> service) {
    return GestureDetector(
      onTap: () {
        Get.to(const ProductDetailScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
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
            // 🔹 IMAGE + CATEGORY TAG
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
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
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      service["category"]!,
                      style: const TextStyle(
                          color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 🔹 TITLE
            Row(
              children: [
                const Icon(Icons.build,
                    color: Colors.blue, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    service["title"]!,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            // 🔹 PROVIDER
            Text(
              service["provider"]!,
              style:
              const TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 10),

            // 🔹 PRICE + RATING
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  service["price"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    fontSize: 15,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star,
                        color: Colors.amber, size: 14),
                    const SizedBox(width: 3),
                    Text(service["rating"]!),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}