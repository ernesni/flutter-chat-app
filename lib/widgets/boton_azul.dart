
import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {

  final String textBtn;
  final Function() onPressed;

  const BotonAzul({ 
    Key? key,
    required this.textBtn,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(textBtn,
                style: const TextStyle(color: Colors.white, fontSize: 17)),
          )),
    );
  }
}