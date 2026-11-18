import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class DeviceController {
  final ImagePicker _picker = ImagePicker();

  // 1 & 2: Capture from Camera or Select from Gallery
  Future<String?> getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    return image?.path;
  }

  // 5, 7, 8: Obtain GPS Location and Handle Runtime Permissions
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception(
        'Location services are disabled.',
      ); // Permission denied message
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission =
          await Geolocator.requestPermission(); // Handle runtime permission
      if (permission == LocationPermission.denied) {
        throw Exception(
          'Location permissions are denied.',
        ); // Permission denied message
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
