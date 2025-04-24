import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/pages/order_entry_page.dart';
import 'app/controllers/order_controller.dart';

void main() {
  Get.put(OrderController());
  // Inject controller globally
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media Design Order',
      theme: ThemeData(primarySwatch: Colors.pink),
      home: OrderEntryPage(),
    );
  }
}
