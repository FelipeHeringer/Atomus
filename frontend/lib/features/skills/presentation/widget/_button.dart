import 'package:flutter/material.dart';

class SkillsButtons extends StatelessWidget {
  final String? iconString;
  final String hint;
  final double width;
  final double height;
  final VoidCallback onPressed;

  const SkillsButtons({
    Key? key,
    this.iconString,
    required this.hint,
    required this.width,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        side: BorderSide(color: Theme.of(context).colorScheme.secondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        minimumSize: Size(width, height),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Row(
          children: [
            if (iconString != null) Image.asset(iconString!,width: 30, height: 30 ),
            SizedBox(width: iconString != null ? 8 : 0),
            Text(hint, style: TextStyle(fontSize: 16, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
