import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'note.dart';

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;
  final List<Note> currentNotes = [];

  // INITIALIZATION
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([NoteSchema], directory: dir.path);
  }

  // CREATE - a note and save to db
  Future<void> addNote(String textFromUser) async {
    final newNote = Note()..text = textFromUser;

    await isar.writeTxn(() => isar.notes.put(newNote));
    //
    await fetchNotes();
  }

  // READ - notes from db
  Future<void> fetchNotes() async {
    List<Note> fetchNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchNotes);
    notifyListeners();
  }

  // UPDATE - a note in db
  Future<void> updateNote(int id, String newText) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.text = newText;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      //
      await fetchNotes();
    }
  }

  // DELETE - a note from db
  Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    //
    await fetchNotes();
  }
}
