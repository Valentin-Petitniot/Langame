import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WordInput extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String hintText;
  final String? label;

  const WordInput(
      {this.onChanged, required this.hintText, this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return label != null
        ? Center(
          child: TextField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                hintText: hintText,
                label: Text(label!, style: TextStyle(
                  color: Colors.white,
                )),
              ),
              onChanged: onChanged,
            ),
        )
        : Center(
          child: TextField(
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                hintText: hintText,
              ),
              onChanged: onChanged,
            ),
        );
  }
}
