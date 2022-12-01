import 'package:appsqflite/provider/note_provider.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../database/notes_db.dart';
import '../model/note.dart';
import 'edit_note_page.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;

  const NoteDetailPage({
    Key? key,
    required this.noteId,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false)
        .refreshNote(widget.noteId);
  }

  @override
  Widget build(BuildContext context) => Consumer<NoteProvider>(
        builder: ((context, value, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Text('Notes'),
              actions: [editButton(context), deleteButton()],
            ),
            body: value.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(12),
                    child: ListView(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      children: [
                        Text(
                          value.note.title,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat.yMMMd().format(value.note.createdTime),
                          style: const TextStyle(color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          value.note.description,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        )
                      ],
                    ),
                  ),
          );
        }),
      );

  Widget editButton(context) => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (Provider.of<NoteProvider>(context).isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              AddEditNotePage(note: Provider.of<NoteProvider>(context).note),
        ));
      });

  Widget deleteButton() => IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () async {
          Provider.of<NoteProvider>(context).deleteNote(widget.noteId);
          Navigator.of(context).pop();
        },
      );
}
