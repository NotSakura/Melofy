import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'select_music_screen.dart';

class SelectMediaScreen extends StatefulWidget {
  const SelectMediaScreen({super.key});

  @override
  State<SelectMediaScreen> createState() => _SelectMediaScreenState();
}

class _SelectMediaScreenState extends State<SelectMediaScreen> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _selectedImage;

  /// ✅ Pick image from gallery
  Future<void> _pickSinglePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final imageBytes = await image.readAsBytes();
      setState(() {
        _selectedImage = imageBytes;
      });
    }
  }

  /// ✅ Choose and go to music selection
  void _chooseImage() {
    if (_selectedImage != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SelectMusicScreen(selectedImage: _selectedImage!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonHeight = 70.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Media"),
      ),
      body: _selectedImage == null
          ? Center(
              child: ElevatedButton(
                onPressed: _pickSinglePhoto,
                child: const Text("Pick Photo from Library"),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        _selectedImage!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),

                /// ✅ Buttons Row
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _pickSinglePhoto,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, buttonHeight),
                            backgroundColor: const Color.fromARGB(255, 255, 187, 109),
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("Select Media"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _chooseImage,
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, buttonHeight),
                            backgroundColor: const Color.fromARGB(255, 189, 130, 203),
                            foregroundColor: Colors.black,
                          ),
                          child: const Text("Choose"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
