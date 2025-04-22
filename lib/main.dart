import 'package:flutter/material.dart';
import 'package:notes/notes_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    locale: Locale('ar'),
    supportedLocales: [
      Locale('ar', ''),
      Locale('en', ''),
    ],
    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    home: NotesScreen(),
  ));
}
