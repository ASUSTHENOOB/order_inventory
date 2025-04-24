import 'package:image_picker/image_picker.dart';
import 'package:cross_file/src/types/interface.dart';

class ProductItem {
  String name;
  int quantity;
  String? note;
  XFile? image;

  ProductItem({this.name = '', this.quantity = 0, this.note, this.image});
}
