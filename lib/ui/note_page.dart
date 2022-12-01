// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../database/notes_db.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../model/note.dart';
import '../provider/note_provider.dart';
import '../widget/note_card_widget.dart';
import 'edit_note_page.dart';
import 'note_detail_page.dart';

class NotesPage extends StatefulWidget {
  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteProvider>(context, listen: false).readAllNotes();
    // notes = Provider.of<NoteProvider>(context).notes;
  }

  @override
  Widget build(BuildContext context) => Consumer<NoteProvider>(
        builder: ((context, value, child) {

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.black,
              title: const Text(
                'Notes',
                style: TextStyle(fontSize: 24),
              ),
              // ignore: prefer_const_literals_to_create_immutables
            ),
            body: Center(
              child: value.isLoading
                  ? const CircularProgressIndicator()
                  : value.notes.isEmpty
                      ? const Text(
                          'No Notes',
                          style: TextStyle(color: Colors.white, fontSize: 24),
                        )
                      : StaggeredGridView.countBuilder(
                          padding: const EdgeInsets.all(8),
                          itemCount: value.notes.length,
                          staggeredTileBuilder: (index) =>
                              const StaggeredTile.fit(2),
                          crossAxisCount: 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          itemBuilder: (context, index) {
                            final note = value.notes[index];
                            return GestureDetector(
                              onTap: () async {
                                await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) =>
                                      NoteDetailPage(noteId: note.id!),
                                ));
                                Provider.of<NoteProvider>(context,
                                        listen: false)
                                    .notes;
                                // refreshNotes();
                              },
                              child: NoteCardWidget(note: note, index: index),
                            );
                          },
                        ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.pink,
              child: const Icon(Icons.add),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddEditNotePage()),
                );
                // ignore: use_build_context_synchronously
                Provider.of<NoteProvider>(context, listen: false).readAllNotes();
              },
            ),
          );
        }),
      );

  // Widget buildNotes() =>;
}
