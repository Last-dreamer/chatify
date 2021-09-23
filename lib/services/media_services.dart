
import 'package:image_picker/image_picker.dart';

class MediaServices {
  static MediaServices instance = MediaServices();

  Future getImageFromLibrary() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }
}