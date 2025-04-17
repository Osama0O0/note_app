import 'package:flutter/material.dart';
import 'package:notes/database_helper.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  _saveNote() async {
    final title = _titleController.text;
    final content = _contentController.text;

    if (title.isNotEmpty && content.isNotEmpty) {
      final note = {
        'title': title,
        'content': content,
        'dateCreated': DateTime.now().toString(),
      };
      await DatabaseHelper.instance.insertNote(note);
      if (mounted) {
        Navigator.pop(context);
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة ملاحظة'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'العنوان'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'المحتوى'),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveNote,
              child: Text('حفظ الملاحظة'),
            ),
          ],
        ),
      ),
    );
  }
}
