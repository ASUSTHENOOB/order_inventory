import 'package:image_picker/image_picker.dart' as picker;

class OrderItem {
  String? productName;
  String? note;
  picker.XFile? image; // Use the alias here
  int? quantity;

  OrderItem({this.productName, this.note, this.image, this.quantity});

  bool get isValid =>
      (productName?.isNotEmpty ?? false) && (quantity != null && quantity! > 0);
}
