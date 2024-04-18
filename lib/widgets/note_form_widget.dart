import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  const NoteFormWidget(
      {super.key,
      required this.isImportant,
      required this.number,
      required this.title,
      required this.description,
      required this.onChangedImportant,
      required this.onChangedNumber,
      required this.onChangedTitle,
      required this.onChangedDescription});

  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Switch(value: isImportant, onChanged: onChangedImportant),
                Expanded(child: Slider(
                  value: number.toDouble(),
                  min: 0,
                  max: 5,
                  divisions: 5,
                  onChanged: (value) => onChangedNumber(value.toInt()),
                ),),
              ]
            ),
            _buildTitleField(),
            const SizedBox(height: 8,),
            _buildDescriptionField(),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      maxLines: null,
      initialValue: description,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Type something...',
        hintStyle: TextStyle(color: Colors.grey,),
      ),
      onChanged: onChangedDescription,
      validator: (desc) {
        return desc != null && desc.isEmpty ? 'The desc cannot be empty' : null;
      },
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.grey,),
      ),
      onChanged: onChangedTitle,
      validator: (title) {
        return title != null && title.isEmpty ? 'The title cannot be empty' : null;
      },
    );
  }
}
