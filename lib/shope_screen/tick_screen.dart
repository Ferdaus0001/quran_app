import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';

class TicketDownloadScreen extends StatefulWidget {
  const TicketDownloadScreen({super.key});

  @override
  State<TicketDownloadScreen> createState() => _TicketDownloadScreenState();
}

class _TicketDownloadScreenState extends State<TicketDownloadScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Future<void> _downloadTicket() async {
    try {
      final Uint8List? image = await _screenshotController.capture(pixelRatio: 3.0);
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/glasto_ticket.png';
      final file = File(filePath);
      await file.writeAsBytes(image);

      await Gal.putImage(file.path, album: "Tickets");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Ticket downloaded successfully to Gallery! 🎉"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Download failed: ${e.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _shareTicket() async {
    try {
      final Uint8List? image = await _screenshotController.capture(pixelRatio: 3.0);
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/glasto_ticket.png';
      final file = File(filePath);
      await file.writeAsBytes(image);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: "My Glastonbury Ticket - ORD-MKZAH728",
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Sharing failed")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Your Ticket",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Success Header (একই আছে)
            const CircleAvatar(
              radius: 36,
              backgroundColor: Color(0xFF4ADE80),
              child: Icon(Icons.check, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              "Order Confirmed!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Thank you for your order. Your Order ID is:",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const Text(
              "ORD-MKZAH728",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),

            // Ticket Card
            Screenshot(
              controller: _screenshotController,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Top Gray Header
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2C2C2C),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Glastonbury",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Ticket Holder", style: TextStyle(fontSize: 14, color: Colors.grey)),
                          const Text("Adam Smith", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 24),

                          Row(
                            children: [
                              _buildInfoItem(icon: Icons.location_on_outlined, label: "Venue", value: "Euston"),
                              const Spacer(),
                              _buildInfoItem(
                                icon: Icons.calendar_today_outlined,
                                label: "Date",
                                value: "Friday, July\n30, 2026",
                                alignRight: true,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          Row(
                            children: [
                              _buildInfoItem(icon: Icons.access_time_outlined, label: "Time", value: "TBD"),
                              const Spacer(),
                              _buildInfoItem(
                                icon: Icons.attach_money_outlined,
                                label: "Price",
                                value: "\$357.99",
                                alignRight: true,
                              ),
                            ],
                          ),

                          const SizedBox(height: 28),

                          // Barcode
                          Center(
                            child: BarcodeWidget(
                              barcode: Barcode.code128(),
                              data: "TK1-MKJA-9-0-2",
                              width: 280,
                              height: 80,
                              drawText: false,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Center(
                            child: Text(
                              "TK1-MKJA-9-0-2",
                              style: TextStyle(fontSize: 13, letterSpacing: 4),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Bottom Dashed Line → Fixed (Solid Gray Line)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.grey, width: 1), // dashed সরানো হয়েছে
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Present this ticket at the venue entrance",
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _shareTicket,
                    icon: const Icon(Icons.share_outlined),
                    label: const Text("Share"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _downloadTicket,
                    icon: const Icon(Icons.download_rounded),
                    label: const Text("Download"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text("Seats: 59", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    bool alignRight = false,
  }) {
    return Column(
      crossAxisAlignment: alignRight ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: Colors.grey),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          textAlign: alignRight ? TextAlign.right : TextAlign.left,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}