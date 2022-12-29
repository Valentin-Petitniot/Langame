import 'package:flutter/material.dart';

import 'package:langame/Cards/Add_Word_Card.dart';

class AddWordButton extends StatelessWidget {
  const AddWordButton({super.key, required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: Colors.transparent,
        splashColor: Colors.lightBlueAccent,
        child: Text(
          '+',
          style: TextStyle(
            fontSize: 40,
            color: Colors.lightBlueAccent,
          ),
        ),
      ),
    );
  }
}
