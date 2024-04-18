import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/database/note_database.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/pages/add_edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  const NoteDetailPage({super.key, required this.id});

  final int id;

  @override
  State<NoteDetailPage> createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late Note _note;
  var _isLoading = false;

  Future<void> _refreshNote() async {
    setState(() {
      _isLoading = true;
    });
    _note = await NoteDatabase.instance.getNoteById(widget.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshNote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        actions: [
          _editButton(),
          _deleteButton(),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Text(
                  _note.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(DateFormat.yMMMd().format(_note.createdTime)),
                SizedBox(
                  height: 8,
                ),
                Text(
                  _note.description,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                )
              ],
            ),
    );
  }

  Widget _editButton() {
    return IconButton(
      onPressed: () async {
        if (_isLoading) return;
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEditNotePage(note: _note)));
        _refreshNote();
      },
      icon: const Icon(Icons.edit_outlined),
    );
  }

  Widget _deleteButton() {
    return IconButton(
      onPressed: () async {
        if (_isLoading) return;
        await NoteDatabase.instance.deleteNoteById(widget.id);
        Navigator.pop(context);
      },
      icon: const Icon(Icons.delete),
    );
  }
}
