import 'package:flutter/material.dart';
import '../models/note.dart';
import 'note_editor_screen.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  List<Note> notes = [];

  void addOrEditNote(Note? note) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditor(note: note),
      ),
    );

    if (result != null) {
      if (note != null) {
        setState(() {
          notes[notes.indexOf(note)] = result;
        });
      } else {
        setState(() {
          notes.add(result);
        });
      }
    }
  }

  void deleteNote(Note note) {
    setState(() {
      notes.remove(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => addOrEditNote(null),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return ListTile(
            title: Text(note.title),
            subtitle: Text(note.content),
            onTap: () => addOrEditNote(note),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => deleteNote(note),
            ),
          );
        },
      ),
    );
  }
}