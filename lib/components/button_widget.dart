import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String? text;
  final Color? color;
  final Function? onPressed;

  const ButtonWidget({
    Key? key,
    this.text,
    this.color,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color!,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () => onPressed!(),
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
