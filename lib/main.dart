import 'package:flutter/material.dart';
import 'tribute_selection_screen.dart';

void main() => runApp(TributeApp());

class TributeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tribute Market',
      theme: ThemeData(primarySwatch: Colors.red, fontFamily: 'NotoSerifSC'),
      home: TributeSelectionScreen(),
    );
  }
}