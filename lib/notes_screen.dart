import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/add_note_screen.dart';
import 'package:notes/database_helper.dart';
import 'package:intl/date_symbol_data_local.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String, dynamic>> _notes = [];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ar_SA', null).then((_) {
      _loadNotes();
    });
  }

  _loadNotes() async {
    final notes = await DatabaseHelper.instance.getAllNotes();
    setState(() {
      _notes = notes.reversed.toList();
    });
  }

  String _formatDate(String rawDate) {
    final date = DateTime.parse(rawDate);
    return DateFormat.yMMMMd('ar_SA').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          '📝 مذكرات سريعة',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: _notes.isEmpty
          ? const Center(
              child: Text(
                'لا توجد مذكرات بعد 😴',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      textAlign: TextAlign.right,
                      overflow: TextOverflow.ellipsis,
                      note['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        textAlign: TextAlign.right,
                        note['content'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    trailing: Text(
                      _formatDate(note['dateCreated']),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    onTap: () {},
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNoteScreen()),
          );
          _loadNotes();
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
