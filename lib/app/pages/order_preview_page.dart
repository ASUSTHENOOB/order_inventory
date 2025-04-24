import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/order_controller.dart';

class OrderPreviewPage extends StatelessWidget {
  final controller = Get.find<OrderController>();
  final String orderNumber = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Preview"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final totalQty = controller.items.fold<int>(
            0,
            (sum, item) =>
                item.isValid
                    ? sum + int.tryParse(item.quantity?.toString() ?? '0')!
                    : sum,
          );

          final estimatedTotal = totalQty * 5; // Example multiplier per item
          final deliveryDate = DateTime.now().add(Duration(days: 2));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Number: $orderNumber',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Order Name: Anthony, Order',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Delivery Date: ${deliveryDate.day}/${deliveryDate.month}/${deliveryDate.year}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'Location: 221B Baker Street, London, UK',
                style: GoogleFonts.publicSans(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Divider(thickness: 1),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    if (!item.isValid) return SizedBox();
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(item.productName ?? ''),
                        subtitle: Text(
                          "Qty: ${item.quantity}",
                          style: GoogleFonts.publicSans(
                            textStyle: TextStyle(
                              color: Colors.teal,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if ((item.note?.isNotEmpty ?? false))
                              Icon(Icons.notes, color: Colors.teal),
                            if (item.image != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(Icons.image, color: Colors.teal),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Total Quantity: $totalQty',
                style: GoogleFonts.publicSans(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Estimated Total: ₹$estimatedTotal',
                style: GoogleFonts.publicSans(
                  textStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton.icon(
                    onPressed: () => Get.back(),
                    icon: Icon(Icons.clear),
                    label: Text("Deduct"),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.snackbar(
                        "Confirmed",
                        "Order submitted successfully!",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.teal,
                        colorText: Colors.white,
                      );
                      // TODO: Add final submission logic
                    },
                    icon: Icon(Icons.check, color: Colors.black),
                    label: Text(
                      "Confirm",
                      style: GoogleFonts.publicSans(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade400,
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}
