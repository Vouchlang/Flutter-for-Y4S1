import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  File? _imageFile;
  String? _downloadUrl;
  bool _isUploading = false;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadFile() async {
    if (_imageFile == null) return;
    setState(() {
      _isUploading = true;
    });

    try {
      // Define the path where the file will be stored
      final storageRef = FirebaseStorage.instance.ref().child(
        'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      // Upload the file
      await storageRef.putFile(_imageFile!);

      // Get the file URL
      final url = await storageRef.getDownloadURL();

      setState(() {
        _downloadUrl = url;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File uploaded successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload to Firebase Storage')),
      body: Center(
        child: Column(
          children: [
            if (_imageFile != null)
              Image.file(_imageFile!, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isUploading ? null : _uploadFile,
              child: _isUploading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('Upload to Firebase'),
            ),
            const SizedBox(height: 20),
            if (_downloadUrl != null)
              Column(
                children: [
                  const Text(
                    'Uploaded Image URL:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _downloadUrl!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
