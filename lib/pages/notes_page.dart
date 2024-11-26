import 'package:flutter/material.dart';
import 'package:isar_notepad/models/note_database.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    readNotes();
  }

  // create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create Note"),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              if (textController.text != '') {
                context.read<NoteDatabase>().addNote(textController.text);
                textController.clear();
                //
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Text field is empty"),
                ));
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  // read notes
  void readNotes() {
    context.read<NoteDatabase>().fetchNotes();
  }

  // update a note
  void updateNote(Note note) {
    textController.text = note.text;
    //
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Note"),
        content: TextField(controller: textController),
        actions: [
          MaterialButton(
            onPressed: () {
              if (textController.text != '') {
                context
                    .read<NoteDatabase>()
                    .updateNote(note.id, textController.text);
                textController.clear();
                //
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text("Text field is empty"),
                ));
              }
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  // delete a note
  void deleteNote(int id) {
    context.read<NoteDatabase>().deleteNote(id);
  }

  @override
  Widget build(BuildContext context) {
    // note database
    final noteDatabase = context.watch<NoteDatabase>();

    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      appBar: AppBar(title: const Text('Notes'), centerTitle: true),
      body: ListView.builder(
        itemCount: currentNotes.length,
        itemBuilder: (BuildContext context, int index) {
          final note = currentNotes[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                leading: Text('ID: ${note.id}'),
                title: Text(note.text),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => updateNote(note),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteNote(note.id),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => createNote(),
      ),
    );
  }
}
