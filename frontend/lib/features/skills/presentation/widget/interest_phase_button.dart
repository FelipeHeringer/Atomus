// lib/features/skills/presentation/widget/phase_expansion_tile.dart

import 'package:flutter/material.dart';
import 'package:frontend/features/skills/presentation/widget/interest_week_button.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestPhaseButton extends StatefulWidget {
  final String phaseTitle;
  final Map<String, dynamic> weeksData;

  const InterestPhaseButton({
    super.key,
    required this.phaseTitle,
    required this.weeksData,
  });

  @override
  State<InterestPhaseButton> createState() => _InterestPhaseButtonState();
}

class _InterestPhaseButtonState extends State<InterestPhaseButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            minimumSize: const Size(363, 65),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            widget.phaseTitle,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 12),
        if (_isExpanded)
          ...widget.weeksData.entries
              .where((entry) => entry.key.startsWith('week_'))
              .map(
                (entry) => InterestWeekButton(
                  title: entry.value['title'],
                  activities: entry.value['activities'],
                ),
              )
      ],
    );
  }
}
