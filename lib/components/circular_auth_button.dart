import 'package:flutter/material.dart';

import '../constants/constants.dart';

class CircularAuthButton extends StatelessWidget {
  final Function() onTap;
  const CircularAuthButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Material(
        elevation: 2.0,
        shape: CircleBorder(),
        color: Constants.darkThemeColor,
        child: SizedBox(
          width: 80.0,
          height: 80.0,
          child: Icon(Icons.arrow_forward, color: Colors.white, size: 30.0),
        ),
      ),
    );
  }
}
