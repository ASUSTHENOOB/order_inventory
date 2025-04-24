import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart' as picker;

import '../models/order_item.dart';

class OrderController extends GetxController {
  RxList<OrderItem> items = <OrderItem>[OrderItem()].obs;

  void addItemIfLastFilled() {
    if (items.isNotEmpty && items.last.isValid) {
      items.add(OrderItem());
    }
  }

  void updateProductName(int index, String name) {
    items[index].productName = name;
    items.refresh();
    addItemIfLastFilled();
  }

  void updateNote(int index, String note) {
    items[index].note = note;
    items.refresh();
  }

  void updateImage(int index, picker.XFile image) {
    items[index].image = image;
    items.refresh();
  }

  void deleteItemAt(int index) {
    if (items.length > 1) {
      items.removeAt(index);
    } else {
      // If it's the only item, just reset it
      items[0] = OrderItem();
    }
  }

  void updateQuantity(int index, String qty) {
    items[index].quantity = int.tryParse(qty) ?? 0;
    items.refresh();
    addItemIfLastFilled();
  }

  bool get hasValidItem => items.any((item) => item.isValid);

  void resetForm() {
    items.clear();
    items.add(OrderItem());
  }
}
