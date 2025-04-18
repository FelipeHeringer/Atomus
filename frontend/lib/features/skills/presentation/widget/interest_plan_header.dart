import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestPlanHeader extends StatelessWidget {
  final String iconPath;
  final String title;
  final String description;

  const InterestPlanHeader({
    super.key,
    required this.iconPath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          iconPath,
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 20,),
        Text(
          title,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),
        Text(
          description,
          style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
