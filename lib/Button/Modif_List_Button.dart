import 'package:flutter/material.dart';

class ModifListButton extends StatelessWidget {
  const ModifListButton({Key? key, required this.onPressed}) : super(key: key);

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: RawMaterialButton(
        onPressed: onPressed,
        fillColor: Colors.transparent,
        elevation: 0,
        child: const Icon(
          Icons.edit,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
