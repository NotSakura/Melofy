
import 'dart:io'; // ✅ This is required for File
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SelectMediaScreen extends StatefulWidget {
  const SelectMediaScreen({super.key});

  @override
  State<SelectMediaScreen> createState() => _SelectMediaScreenState();
}

class _SelectMediaScreenState extends State<SelectMediaScreen> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _pickedImages = [];

  Future<void> _pickFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        setState(() {
          _pickedImages = images;
        });
      }
    } catch (e) {
      print("Error picking images: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to access the photo library.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Media')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickFromGallery,
            child: const Text("Pick Photos from Library"),
          ),
          Expanded(
            child: _pickedImages.isEmpty
                ? const Center(child: Text("No photos selected."))
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // ✅ 3x3 Grid
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                    ),
                    itemCount: _pickedImages.length,
                    itemBuilder: (context, index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(_pickedImages[index].path), // ✅ File import fixed
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
