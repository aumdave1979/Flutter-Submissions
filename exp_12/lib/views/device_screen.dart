import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:exp_12/controllers/devices_controller.dart';
import 'package:image_picker/image_picker.dart';

class DeviceScreen extends StatefulWidget {
  const DeviceScreen({super.key});

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  final DeviceController _controller = DeviceController();

  String? _imagePath;
  String _locationData = "Location not fetched yet";
  String _permissionMessage = "";

  void _pickImage(ImageSource source) async {
    final path = await _controller.getImage(source);
    if (path != null) {
      setState(() {
        _imagePath = path; // 3. Display and replace the selected image
        _permissionMessage = "";
      });
    }
  }

  void _fetchLocation() async {
    try {
      final position = await _controller.getCurrentLocation();
      setState(() {
        _locationData =
            "Lat: ${position.latitude}\nLon: ${position.longitude}"; // 6. Display location dynamically
        _permissionMessage = "";
      });
    } catch (e) {
      setState(() {
        _permissionMessage = e
            .toString(); // 8. Display appropriate messages when denied
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Device Utilities')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Error Message Display
            if (_permissionMessage.isNotEmpty)
              Text(
                _permissionMessage,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 20),

            // Image Display area
            Container(
              height: 200,
              width: 200,
              color: Colors.grey[300],
              child: _imagePath == null
                  ? const Center(child: Text('No image selected'))
                  : Image.file(File(_imagePath!), fit: BoxFit.cover),
            ),
            const SizedBox(height: 10),

            // Camera & Gallery Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera),
                  label: const Text('Camera'),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),
                const SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo),
                  label: const Text('Gallery'),
                  onPressed: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),

            const Divider(height: 40, thickness: 2),

            // 4 & 6. Read and display accelerometer data dynamically
            const Text(
              'Accelerometer Data:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            StreamBuilder<AccelerometerEvent>(
              stream: accelerometerEventStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                final event = snapshot.data!;
                return Text(
                  'X: ${event.x.toStringAsFixed(2)}\nY: ${event.y.toStringAsFixed(2)}\nZ: ${event.z.toStringAsFixed(2)}',
                );
              },
            ),

            const Divider(height: 40, thickness: 2),

            // Location Display and Button
            const Text(
              'GPS Location:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(_locationData, textAlign: TextAlign.center),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _fetchLocation,
              child: const Text('Get Current Location'),
            ),
          ],
        ),
      ),
    );
  }
}
