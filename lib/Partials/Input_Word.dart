import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WordInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;
  
  const WordInput({this.onChanged, required this.hintText, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        hintText: hintText,
      ),
      onChanged: onChanged,
    );
  }
}
