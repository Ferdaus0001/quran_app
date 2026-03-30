import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  // Location
  String? selectedCity = "London";
  String? selectedCountry;

  // Sort By
  String selectedSort = "Newest First";

  // Price Range
  double priceRange = 1000;

  // Wholesale Only
  bool wholesaleOnly = true;

  // Minimum Rating
  int? minRating; // null means "Any"

  // Gender
  String? selectedGender;

  // Brands
  String? selectedBrand = "Nike";

  final List<String> sortOptions = [
    "Newest First",
    "Price: Low to High",
    "Price: High to Low",
    "Highest Rated",
    "Most Popular",
  ];

  final List<String> genderOptions = ["Man", "Women", "Unisex", "Kids"];

  final List<String> brands = [
    "Nike",
    "Adidas",
    "Apple",
    "Samsung",
    "Sony",
    "Zara",
    "H&M",
    "Gucci",
    "Other"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop Filter"),
        actions: [
          TextButton(
            onPressed: () {
              // Reset all filters
              setState(() {
                selectedCity = "London";
                selectedCountry = null;
                selectedSort = "Newest First";
                priceRange = 1000;
                wholesaleOnly = true;
                minRating = null;
                selectedGender = null;
                selectedBrand = "Nike";
              });
            },
            child: const Text(
              "Reset all",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Location
              const Text("Location", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildDropdown("City", selectedCity, (value) {
                      setState(() => selectedCity = value);
                    }),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildDropdown("Country", selectedCountry, (value) {
                      setState(() => selectedCountry = value);
                    }),
                  ),
                ],
              ),
        
              const SizedBox(height: 24),
        
              // Sort By
              const Text("Sort By", style: TextStyle(fontWeight: FontWeight.bold)),
              ...sortOptions.map((option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedSort,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(() => selectedSort = value!);
                },
              )),
        
              const SizedBox(height: 24),
        
              // Price Range
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Price Range: \$0 - \$$priceRange",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Slider(
                value: priceRange,
                min: 0,
                max: 1000,
                divisions: 100,
                activeColor: Colors.red,
                inactiveColor: Colors.grey[300],
                onChanged: (value) {
                  setState(() => priceRange = value);
                },
              ),
        
              const SizedBox(height: 24),
        
              // Wholesale Only
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Wholesale Only", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Show only products available for bulk purchase",
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  Switch(
                    value: wholesaleOnly,
                    activeColor: Colors.red,
                    onChanged: (value) {
                      setState(() => wholesaleOnly = value);
                    },
                  ),
                ],
              ),
        
              const SizedBox(height: 24),
        
              // Minimum Rating
              const Text("Minimum Rating", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildRatingChip("Any", null),
                  const SizedBox(width: 8),
                  ...List.generate(5, (index) => _buildRatingChip("${index + 1}", index + 1)),
                ],
              ),
        
              const SizedBox(height: 24),
        
              // Gender
              const Text("Gender", style: TextStyle(fontWeight: FontWeight.bold)),
              ...genderOptions.map((gender) => RadioListTile<String>(
                title: Text(gender),
                value: gender,
                groupValue: selectedGender,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(() => selectedGender = value);
                },
              )),
        
              const SizedBox(height: 24),
        
              // Brands
              const Text("Brands", style: TextStyle(fontWeight: FontWeight.bold)),
              ...brands.map((brand) => RadioListTile<String>(
                title: Text(brand),
                value: brand,
                groupValue: selectedBrand,
                activeColor: Colors.red,
                onChanged: (value) {
                  setState(() => selectedBrand = value);
                },
              )),
        
              const SizedBox(height: 30),
        
              // Apply Filter Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // You can print or send filter data here
                    print("Applied Filters:");
                    print("City: $selectedCity");
                    print("Country: $selectedCountry");
                    print("Sort: $selectedSort");
                    print("Price Max: \$$priceRange");
                    print("Wholesale Only: $wholesaleOnly");
                    print("Min Rating: ${minRating ?? 'Any'}");
                    print("Gender: ${selectedGender ?? 'Any'}");
                    print("Brand: $selectedBrand");
        
                    Navigator.pop(context); // Close screen after apply
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    "Apply Filter",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            hint: Text("Enter", style: TextStyle(color: Colors.grey.shade400)),
            items: value == null
                ? null
                : [
              DropdownMenuItem(
                value: value,
                child: Text(value),
              )
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildRatingChip(String label, int? rating) {
    bool isSelected = minRating == rating;
    return GestureDetector(
      onTap: () {
        setState(() => minRating = rating);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (rating != null)
              const Icon(Icons.star, color: Colors.amber, size: 16),
          ],
        ),
      ),
    );
  }
}