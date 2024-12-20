
import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {

final String text;
final void Function() ?onPressed;

  const ButtonBlue({
    super.key, 
    required this.text,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
     return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: Colors.blue,
        shape: const StadiumBorder(),
      ),

      onPressed: onPressed, 
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(text, style: const TextStyle( color: Colors.white, fontSize: 17 )),
        ),
      )
    );
  }
}