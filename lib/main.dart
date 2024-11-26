import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/note_database.dart';
import 'pages/notes_page.dart';
import 'theme/app_theme.dart';

void main() async {
  // initialization note isar database
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteDatabase(),
      child: MaterialApp(
        title: 'Isar Notepad',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.data(),
        home: const NotesPage(),
      ),
    ),
  );
}
