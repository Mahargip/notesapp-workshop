import 'package:flutter/material.dart';
import 'package:noteapp/database/note_database.dart';
import 'package:noteapp/models/note.dart';
import 'package:noteapp/widgets/note_form_widget.dart';

class AddEditNotePage extends StatefulWidget {
  const AddEditNotePage({super.key, this.note});

  final Note? note;

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  late bool _isImportant;
  late int _number;
  late String _title;
  late String _description;
  final _formKey = GlobalKey<FormState>();
  var _isUpdateForm = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isImportant = widget.note?.isImportant ?? false;
    _number = widget.note?.number ?? 0;
    _title = widget.note?.title ?? '';
    _description = widget.note?.description ?? '';
    _isUpdateForm = widget.note != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isUpdateForm ? 'Edit Note' : 'Add Note'),
        actions: [
          _buildButtonSave(),
        ],
      ),
      body: Form(
        key: _formKey,
          child: NoteFormWidget(
              isImportant: _isImportant,
              number: _number,
              title: _title,
              description: _description,
              onChangedImportant: (value) {
                setState(() {
                  _isImportant = value;
                });
              },
              onChangedNumber: (value) {
                setState(() {
                  _number = value;
                });
              },
              onChangedTitle: (value) {
                setState(() {
                  _title = value;
                });
              },
              onChangedDescription: (value) {
                setState(() {
                  _description = value;
                });
              })),
    );
  }

  Widget _buildButtonSave() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        onPressed: () async {
          final isValid = _formKey.currentState!.validate();
          if (isValid) {
            if (_isUpdateForm) {
              await _updateNote();
            } else {
              await _addNote();
            }
            Navigator.pop(context);
          }
        },
        child: const Text('Save'),
      ),
    );
  }

  Future<void> _addNote() async {
    final note = Note(isImportant: _isImportant,
        number: _number,
        title: _title,
        description: _description,
        createdTime: DateTime.now());
    await NoteDatabase.instance.create(note);
  }

  Future<void> _updateNote() async {
    final updateNote = Note(
        id: widget.note?.id,
        isImportant: _isImportant,
        number: _number,
        title: _title,
        description: _description,
        createdTime: DateTime.now()
    );
    await NoteDatabase.instance.updateNote(updateNote);
  }
}
