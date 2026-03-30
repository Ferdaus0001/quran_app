import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/shope_screen/product_deatils_screen.dart';
import 'filter_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String selectedCategory = "All";

  // 🔹 SAMPLE DATA (add category field)
  final List<Map<String, String>> products = [
    {"title": "Handmade Silver Jewelry", "category": "Fashion"},
    {"title": "Smartphone", "category": "Electronics"},
    {"title": "Leather Shoes", "category": "Fashion"},
    {"title": "Laptop", "category": "Electronics"},
    {"title": "Discount Deal", "category": "Deals"},
    {"title": "Watch", "category": "Fashion"},
    {"title": "Headphones", "category": "Electronics"},
    {"title": "Special Offer", "category": "Deals"},
  ];

  @override
  Widget build(BuildContext context) {
    // 🔥 FILTER LOGIC
    List<Map<String, String>> filteredProducts =
    selectedCategory == "All"
        ? products
        : products
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
                _categoryChip("Fashion"),
                const SizedBox(width: 8),
                _categoryChip("Electronics"),
                const SizedBox(width: 8),
                _categoryChip("Deals"),
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

          // 🔹 GRID
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredProducts.length,
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.60,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final item = filteredProducts[index];
              return _productCard(item["title"]!);
            },
          ),
        ],
      ),
    );
  }

  // 🔴 CATEGORY CHIP (WITH SELECT STATE)
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
          color: isSelected ? Colors.red : Colors.grey[200],
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

  // 🔴 PRODUCT CARD (dynamic title)
  Widget _productCard(String title) {
    return GestureDetector(
      onTap: () {
        Get.to(const ProductDetailScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.12),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 IMAGE
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12)),
                  child: Image.network(
                    "https://tse1.mm.bing.net/th/id/OIP.cW0wzJYojHH-xxW35Wj7dQHaHa",
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

                // NEW BADGE
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      "New",
                      style: TextStyle(
                          color: Colors.white, fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),

            // 🔹 DETAILS
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.shopping_bag,
                          color: Colors.red, size: 18),
                      SizedBox(width: 6),
                    ],
                  ),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Sarah's Jewelry",
                    style: TextStyle(
                        fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$89",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star,
                              color: Colors.amber, size: 14),
                          SizedBox(width: 3),
                          Text("4.9"),
                        ],
                      )
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