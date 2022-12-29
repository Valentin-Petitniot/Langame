import 'package:flutter/material.dart';

class ViewWordsListScreen extends StatefulWidget {
  const ViewWordsListScreen({Key? key}) : super(key: key);

  @override
  State<ViewWordsListScreen> createState() => _ViewWordsListScreenState();
}

class _ViewWordsListScreenState extends State<ViewWordsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lecture Liste'),
      ),
    );
  }
}
