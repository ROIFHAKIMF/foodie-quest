import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageHelper {
  static final ImagePicker _picker = ImagePicker();
///bug return null
  static Future<File?> pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }
}
