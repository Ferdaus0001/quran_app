import 'package:flutter/material.dart';


class SeatSelectionScreen extends StatefulWidget {
  const SeatSelectionScreen({super.key});

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  int selectedSeat = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          onPressed: () {},
        ),
        title: const Text(
          'Select Your Seats',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black, size: 28),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          const Text(
            'Choose 1 seat for Glasstumbury',
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // Legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem(Colors.transparent, 'Available', border: true),
                const SizedBox(width: 24),
                _buildLegendItem(const Color(0xFFE63946), 'Selected'),
                const SizedBox(width: 24),
                _buildLegendItem(const Color(0xFFD1D5DB), 'Taken'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Stage
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 80),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F1F1),
                borderRadius: BorderRadius.circular(8),
                border: const Border(
                  top: BorderSide(color: Color(0xFFE63946), width: 3),
                ),
              ),
              child: const Text(
                'STAGE',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Header: front + available count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'front',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  '200 of 200 available',
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Seats Grid
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: List.generate(42, (index) {
                  final seatNumber = index + 1;
                  final isSelected = seatNumber == selectedSeat;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSeat = seatNumber;
                      });
                    },
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFE63946) : const Color(0xFFF8F9FA),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected ? const Color(0xFFE63946) : const Color(0xFFE5E7EB),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$seatNumber',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, {bool border = false}) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: border
                ? Border.all(color: Colors.grey.shade400, width: 1.5)
                : null,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }
}