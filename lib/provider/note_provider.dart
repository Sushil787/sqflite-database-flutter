import 'dart:developer';

import 'package:appsqflite/database/notes_db.dart';
import 'package:appsqflite/model/note.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqlite_api.dart';

class NoteProvider extends ChangeNotifier {
  // late int noteId;
  late Note note;
  bool _isLoading = false;
  late List<Note> notes;
  bool get isLoading => _isLoading;
  // List<Note> get notes => _notes;

  Future refreshNote(int noteId) async {
    toggleLoading();
    note = await NotesDatabase.instance.readNote(noteId);
    toggleLoading();
    notifyListeners();
  }

  Future deleteNote(int noteId) async {
    note = await NotesDatabase.instance.readNote(noteId);
    notifyListeners();
  }

  Future readAllNotes() async {
    toggleLoading();
    notes = await NotesDatabase.instance.readAllNotes();
    toggleLoading();
    notifyListeners();
  }

  Future addNote(Note note) async {
    log("------------------------------------------------------------------");
    note = await NotesDatabase.instance.create(note);
    log("------------------------------------------------------------------");
    notifyListeners();
  }

  toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
