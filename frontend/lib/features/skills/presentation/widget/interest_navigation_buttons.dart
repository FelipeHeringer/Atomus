import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestNavigationButtons extends StatelessWidget {
  final VoidCallback onStart;

  const InterestNavigationButtons({
    super.key,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(context, '/skills'),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF929292),
            minimumSize: Size(120, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(
            Icons.arrow_back_rounded, size: 23,
            color: Colors.white,
            ),
          label: Text(
            'Voltar',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton.icon(
          onPressed: onStart,
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            minimumSize: Size(120, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          icon: const Icon(
            Icons.arrow_forward_rounded, size: 23,
            color: Colors.white,
            ),
          iconAlignment: IconAlignment.end,
          label: Text(
            'Iniciar Plano',
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}
