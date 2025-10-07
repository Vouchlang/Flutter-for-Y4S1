import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CrudOperationsScreen extends StatefulWidget {
  const CrudOperationsScreen({super.key});

  @override
  State<CrudOperationsScreen> createState() => _CrudOperationsScreenState();
}

class _CrudOperationsScreenState extends State<CrudOperationsScreen> {
  final TextEditingController _textController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  final _user = FirebaseAuth.instance.currentUser;

  Future<void> _createData() async {
    if (_textController.text.isNotEmpty) {
      await _firestore.collection('notes').add({
        'text': _textController.text,
        'userId': _user?.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _textController.clear();
    }
  }

  Future<void> _updateData(String docId, String newText) async {
    await _firestore.collection('notes').doc(docId).update({
      'text': newText,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _deleteData(String docId) async {
    await _firestore.collection('notes').doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firestore CRUD Operations")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Create Data
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      labelText: "Enter note text",
                    ),
                  ),
                ),
                IconButton(onPressed: _createData, icon: const Icon(Icons.add)),
              ],
            ),

            const SizedBox(height: 20),

            // Read, Update, Delete
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('notes')
                    .where('userId', isEqualTo: _user?.uid)
                    .snapshots(),

                builder: (context, snapshot) {
                  if (snapshot.hasError) return Text("Error loading data");
                  if (!snapshot.hasData) return CircularProgressIndicator();

                  final notes = snapshot.data!.docs;

                  if (notes.isEmpty) {
                    return const Center(child: Text("No notes yet."));
                  }

                  return ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final doc = notes[index];
                      final data = doc.data() as Map<String, dynamic>;
                      final text = data['text'] ?? "";

                      return ListTile(
                        title: Text(text),
                        subtitle: Text(
                          data['createdAt']?.toDate().toString() ?? "No date",
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                final controller = TextEditingController(
                                  text: text,
                                );
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Edit Note"),
                                    content: TextField(controller: controller),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          _updateData(doc.id, controller.text);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Save"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteData(doc.id),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
