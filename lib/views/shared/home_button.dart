import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final String buttonLabel;
  final Function() onPress;

  const HomeButton({Key? key, required this.buttonLabel, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200.0, 48.0),
          ),
          onPressed: onPress, child: Text(buttonLabel, style: const TextStyle(fontSize: 16.0),)),
    );
  }
}
