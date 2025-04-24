import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/app/pages/order_preview_page.dart';
import '../controllers/order_controller.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class OrderEntryPage extends StatelessWidget {
  final controller = Get.find<OrderController>();
  final List<TextEditingController> textControllers = [];

  Future<List<String>> fetchSuggestions(String pattern) async {
    try {
      final response = await http.get(
        Uri.parse("https://app.giotheapp.com/api-sample/"),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded is Map) {
          final values =
              decoded.values
                  .where(
                    (value) => value.toString().toLowerCase().contains(
                      pattern.toLowerCase(),
                    ),
                  )
                  .cast<String>()
                  .toList();
          return values;
        } else {
          print("Unexpected JSON format");
          return [];
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching suggestions: $e');
      return [];
    }
  }

  void _showNoteImageSheet(int index) {
    final noteController = TextEditingController(
      text: controller.items[index].note ?? '',
    );

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 205, 239, 236),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Attach Note or Image",
              style: GoogleFonts.publicSans(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: noteController,
              decoration: InputDecoration(
                labelText: 'Note...',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              icon: Icon(Icons.camera_alt, color: Colors.black),
              label: Text(
                'Pick Image',
                style: GoogleFonts.publicSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade100,
                ),
              ),
              onPressed: () async {
                final picker = ImagePicker();
                final picked = await picker.pickImage(
                  source: ImageSource.gallery,
                );
                if (picked != null) {
                  controller.updateImage(index, picked);
                  Get.back(); // Close the sheet
                }
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () {
                controller.updateNote(index, noteController.text);
                Get.back();
              },
              child: Text(
                'Save',
                style: GoogleFonts.publicSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade100,
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      drawer: Drawer(backgroundColor: Colors.grey.shade200),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Order Entry"),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),

      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  if (textControllers.length <= index) {
                    textControllers.add(TextEditingController());
                  }

                  final textEditingController = textControllers[index];
                  final isLast = index == controller.items.length - 1;

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    elevation: 6,
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: GestureDetector(
                        onDoubleTap: () => _showNoteImageSheet(index),
                        onLongPress: () => _showNoteImageSheet(index),

                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              isLast
                                  ? TypeAheadField<String>(
                                    controller: textEditingController,
                                    suggestionsCallback: fetchSuggestions,
                                    builder: (context, controller_, focusNode) {
                                      return TextField(
                                        controller: controller_,
                                        focusNode: focusNode,
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.teal.shade100,
                                              width: 1.5,
                                            ), // Unfocused border
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.teal,
                                              width: 2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          focusColor: Colors.teal,
                                          labelText: 'Product Name',
                                          labelStyle: GoogleFonts.publicSans(
                                            textStyle: TextStyle(
                                              fontSize: 16,
                                              color: Colors.teal,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          fillColor: Colors.grey.shade200,
                                          filled: true,
                                        ),
                                        onChanged:
                                            (value) => this.controller
                                                .updateProductName(
                                                  index,
                                                  value,
                                                ),
                                      );
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(title: Text(suggestion));
                                    },
                                    onSelected: (suggestion) {
                                      textEditingController.text = suggestion;
                                      controller.updateProductName(
                                        index,
                                        suggestion,
                                      );
                                    },
                                  )
                                  : Text(
                                    'Product: ${controller.items[index].productName ?? ""}',
                                    style: GoogleFonts.publicSans(
                                      textStyle: TextStyle(fontSize: 18),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              SizedBox(height: 10),
                              isLast
                                  ? TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.teal.shade100,
                                          width: 1.5,
                                        ), // Unfocused border
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.teal,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusColor: Colors.teal,
                                      labelText: 'Quantity',
                                      labelStyle: GoogleFonts.publicSans(
                                        textStyle: TextStyle(
                                          fontSize: 16,
                                          color: Colors.teal,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      fillColor: Colors.grey.shade200,
                                      filled: true,
                                    ),
                                    onChanged:
                                        (value) => controller.updateQuantity(
                                          index,
                                          value,
                                        ),
                                  )
                                  : Text(
                                    'Qty: ${controller.items[index].quantity}',
                                    style: GoogleFonts.publicSans(
                                      textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      if (controller
                                              .items[index]
                                              .note
                                              ?.isNotEmpty ==
                                          true)
                                        Icon(Icons.info, color: Colors.teal),
                                      if (controller.items[index].image != null)
                                        Icon(
                                          Icons.camera_alt,
                                          color: Colors.teal,
                                        ),
                                    ],
                                  ),
                                  if (controller
                                          .items[index]
                                          .productName
                                          ?.isNotEmpty ==
                                      true)
                                    TextButton(
                                      onPressed: () {
                                        controller.deleteItemAt(index);
                                        if (textControllers.length > index) {
                                          textControllers.removeAt(index);
                                        }
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        size: 19,
                                        color: Colors.teal,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed:
                        controller.hasValidItem
                            ? () => Get.to(
                              () => OrderPreviewPage(),
                              transition: Transition.rightToLeftWithFade,
                              duration: Duration(milliseconds: 400),
                            )
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  OutlinedButton(
                    onPressed:
                        controller.hasValidItem
                            ? () {
                              controller.resetForm();
                              textControllers.clear();
                            }
                            : null,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                      side: BorderSide(color: Colors.teal),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Clean",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
