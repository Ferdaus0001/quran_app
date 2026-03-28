import 'package:flutter/material.dart';

class ProfilePlanScreen extends StatefulWidget {
  const ProfilePlanScreen({super.key});

  @override
  State<ProfilePlanScreen> createState() => _ProfilePlanScreenState();
}

class _ProfilePlanScreenState extends State<ProfilePlanScreen> {
  int selectedPlan = 0; // 0 = Verified (Free), 1 = Business, 2 = Premium Business

  final List<Map<String, dynamic>> plans = [
    {
      'title': 'Verified',
      'price': 'Free',
      'icon': Icons.verified,
      'color': Colors.blue,
      'features': [
        'Free with ID and card verification',
        'Message other users',
        'Send connection & follow requests',
        'Match professionally or socially',
        '+4 more',
      ],
    },
    {
      'title': 'Business',
      'price': 'Free',
      'icon': Icons.business,
      'color': Colors.orange,
      'features': [
        'Free with ID and card verification',
        'All Verified features',
        'List and sell services',
        'List and sell products',
        '+4 more',
      ],
    },
    {
      'title': 'Premium Business',
      'price': '£19.99/mo',
      'icon': Icons.star,
      'color': Colors.amber,
      'features': [
        'Full access to all platform features',
        'All Business features',
        'Create and sell event tickets',
        'Post job listings',
        '+2 more',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Step 6 of 7
              Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 16),
                    children: [
                      TextSpan(text: 'Step ', style: TextStyle(color: Colors.grey)),
                      TextSpan(text: '6', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      TextSpan(text: ' of 7', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 6 / 7,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE0E0E0),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),

              const SizedBox(height: 32),

              // Title
              const Row(
                children: [
                  Icon(Icons.card_giftcard, color: Colors.black87),
                  SizedBox(width: 8),
                  Text(
                    'Choose Your Plan',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Select a subscription plan to unlock features and get verified',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),

              const SizedBox(height: 32),

              // Plans List
              ...List.generate(plans.length, (index) {
                final plan = plans[index];
                final isSelected = selectedPlan == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlan = index;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? plan['color'] : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      color: isSelected ? plan['color'].withOpacity(0.05) : Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Plan Header
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: plan['color'].withOpacity(0.1),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(plan['icon'], color: plan['color'], size: 28),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    plan['title'],
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    plan['price'],
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: plan['color'],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Radio Button
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected ? plan['color'] : Colors.grey,
                                  width: 2,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: plan['color'],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              )
                                  : null,
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Features
                        ...plan['features'].map<Widget>((feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• ', style: TextStyle(fontSize: 16)),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: const TextStyle(fontSize: 14, height: 1.4),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Skip Note
              const Text(
                'You can skip this step and choose a plan later from your account settings.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              // Bottom Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('Previous', style: TextStyle(color: Colors.black87)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to next step or finish
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Selected: ${plans[selectedPlan]['title']} Plan')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Text('Next', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Skip this step', style: TextStyle(color: Colors.grey)),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}