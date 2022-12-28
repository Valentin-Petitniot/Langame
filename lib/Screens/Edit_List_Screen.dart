import 'package:flutter/material.dart';

class EditListScreen extends StatefulWidget {
  const EditListScreen({Key? key}) : super(key: key);

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

class _EditListScreenState extends State<EditListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('oui'),
      ),
    );
  }
}
