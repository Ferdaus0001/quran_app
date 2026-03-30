import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_app/shope_screen/product_deatils_screen.dart';
import 'filter_screen.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  String selectedCategory = "All";

  // 🔹 JOB DATA
  final List<Map<String, String>> jobs = [
    {
      "title": "Senior Jewelry Designer",
      "category": "Full Time",
      "company": "Creative Studio",
      "location": "Dhaka, Bangladesh",
      "salary": "\$500/mo"
    },
    {
      "title": "UI/UX Designer",
      "category": "Remote",
      "company": "Design Hub",
      "location": "Remote",
      "salary": "\$800/mo"
    },
    {
      "title": "Part Time Sales Assistant",
      "category": "Part Time",
      "company": "Retail Shop",
      "location": "Chittagong",
      "salary": "\$200/mo"
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 🔥 FILTER
    List<Map<String, String>> filteredJobs =
    selectedCategory == "All"
        ? jobs
        : jobs
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
                _categoryChip("Full Time"),
                const SizedBox(width: 8),
                _categoryChip("Part Time"),
                const SizedBox(width: 8),
                _categoryChip("Remote"),
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

          // 🔹 JOB LIST (BIG CARDS)
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filteredJobs.length,
            itemBuilder: (context, index) {
              final job = filteredJobs[index];
              return _jobCard(job);
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
          color: isSelected ? Colors.green : Colors.grey[200],
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

  // 🔴 JOB CARD (BIG STYLE)
  Widget _jobCard(Map<String, String> job) {
    return GestureDetector(
      onTap: () {
        Get.to(const ProductDetailScreen());
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(14),
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
            // 🔹 HEADER
            Row(
              children: [
                const CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(
                      "https://tse1.mm.bing.net/th/id/OIP.cW0wzJYojHH-xxW35Wj7dQHaHa"),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    job["company"]!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    job["category"]!,
                    style: const TextStyle(
                        color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 🔹 TITLE
            Text(
              job["title"]!,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            // 🔹 LOCATION
            Row(
              children: [
                const Icon(Icons.location_on,
                    size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  job["location"]!,
                  style: const TextStyle(
                      fontSize: 13, color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // 🔹 SALARY + TYPE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  job["salary"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                    fontSize: 15,
                  ),
                ),
                Text(
                  job["category"]!,
                  style: const TextStyle(
                      fontSize: 13, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}