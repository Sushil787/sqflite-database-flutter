import 'package:appsqflite/provider/note_provider.dart';
import 'package:appsqflite/ui/note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
// subash note app watching
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => NoteProvider())],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  static const String title = 'Notes SQLite';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 0, 0, 0),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
        home: NotesPage(),
      );
}
