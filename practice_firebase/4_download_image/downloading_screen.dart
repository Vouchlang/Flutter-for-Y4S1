import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  List<String> imageUrls = [];
  bool isLoading = false;

  Future<void> fetchImages() async {
    setState(() => isLoading = true);

    try {
      final storageRef = FirebaseStorage.instance.ref().child('uploads');
      final ListResult result = await storageRef.listAll();

      final urls = await Future.wait(
        result.items.map((item) => item.getDownloadURL()).toList(),
      );

      setState(() {
        imageUrls = urls;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Download Images')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : imageUrls.isEmpty
          ? const Center(child: Text('No images found.'))
          : ListView.builder(
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(imageUrls[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchImages,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
