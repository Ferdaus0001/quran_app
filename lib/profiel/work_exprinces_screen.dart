import 'package:flutter/material.dart';

class WorkExperience {
  String company = '';
  String position = '';
  String startDate = '';
  String endDate = '';
  String description = '';
  bool currentlyWorking = false;
}

class ProfileWorkHistory extends StatefulWidget {
  const ProfileWorkHistory({super.key});

  @override
  State<ProfileWorkHistory> createState() => _ProfileWorkHistoryState();
}

class _ProfileWorkHistoryState extends State<ProfileWorkHistory> {
  final List<WorkExperience> _experiences = [WorkExperience()]; // Start with one empty card

  void _addNewExperience() {
    setState(() {
      _experiences.add(WorkExperience());
    });
  }

  void _removeExperience(int index) {
    if (_experiences.length > 1) {
      setState(() {
        _experiences.removeAt(index);
      });
    }
  }

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
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Step 5 of 6
              Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 16),
                    children: [
                      TextSpan(text: 'Step ', style: TextStyle(color: Colors.grey)),
                      TextSpan(text: '5', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      TextSpan(text: ' of 6', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: 5 / 6,
                  minHeight: 8,
                  backgroundColor: const Color(0xFFE0E0E0),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),

              const SizedBox(height: 32),

              // Header
              const Row(
                children: [
                  Icon(Icons.work, size: 28),
                  SizedBox(width: 10),
                  Text(
                    'Work History',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'Add your work experience (optional)',
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),

              const SizedBox(height: 24),

              // Work Experience Cards
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _experiences.length,
                itemBuilder: (context, index) {
                  final exp = _experiences[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 20),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Card Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Work Experience ${index + 1}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              if (_experiences.length > 1)
                                IconButton(
                                  icon: const Icon(Icons.close, color: Colors.red),
                                  onPressed: () => _removeExperience(index),
                                ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Company Name
                          _buildTextField(
                            label: 'Company name',
                            onChanged: (value) => exp.company = value,
                          ),

                          const SizedBox(height: 16),

                          // Position / Title
                          _buildTextField(
                            label: 'Position/Title',
                            onChanged: (value) => exp.position = value,
                          ),

                          const SizedBox(height: 16),

                          // Dates
                          Row(
                            children: [
                              Expanded(
                                child: _buildDateField(
                                  label: 'Start date',
                                  onChanged: (value) => exp.startDate = value,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildDateField(
                                  label: 'End date',
                                  onChanged: (value) => exp.endDate = value,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Job Description
                          _buildTextField(
                            label: 'Job Description',
                            maxLines: 4,
                            onChanged: (value) => exp.description = value,
                          ),

                          const SizedBox(height: 16),

                          // Currently Working Here
                          Row(
                            children: [
                              Checkbox(
                                value: exp.currentlyWorking,
                                activeColor: Colors.red,
                                onChanged: (value) {
                                  setState(() {
                                    exp.currentlyWorking = value ?? false;
                                  });
                                },
                              ),
                              const Text(
                                'I currently work here',
                                style: TextStyle(fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              // Add More Button
              GestureDetector(
                onTap: _addNewExperience,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.grey),
                      SizedBox(width: 8),
                      Text(
                        'Add Work Experience',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 50),

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
                        // Save logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Work history saved!')),
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

  Widget _buildTextField({
    required String label,
    int maxLines = 1,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}