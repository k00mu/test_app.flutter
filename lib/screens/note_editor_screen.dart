import 'package:flutter/material.dart';
import '../models/note.dart';

class NoteEditor extends StatefulWidget {
  final Note? note;

  NoteEditor({this.note});

  @override
  _NoteEditorState createState() => _NoteEditorState();
}

class _NoteEditorState extends State<NoteEditor> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      titleController.text = widget.note!.title;
      contentController.text = widget.note!.content;
    }
  }

  bool hasContent() {
    return titleController.text.isNotEmpty || contentController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (hasContent()) {
          Navigator.pop(
            context,
            Note(
              title: titleController.text,
              content: contentController.text,
            ),
          );
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (hasContent()) {
                Navigator.pop(
                  context,
                  Note(
                    title: titleController.text,
                    content: contentController.text,
                  ),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: TextField(
                  controller: contentController,
                  decoration: InputDecoration(
                    labelText: 'Content',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}