// lib/features/skills/presentation/widget/week_expansion_tile.dart

import 'package:flutter/material.dart';

class InterestWeekButton extends StatefulWidget {
  final String title;
  final List<dynamic> activities;

  const InterestWeekButton({
    super.key,
    required this.title,
    required this.activities,
  });

  @override
  State<InterestWeekButton> createState() => _InterestWeekButtonState();
}

class _InterestWeekButtonState extends State<InterestWeekButton> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1C988B),
            minimumSize: const Size(363, 65),
            shape: RoundedRectangleBorder(
              borderRadius: _isExpanded
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )
                  : BorderRadius.circular(8),
            ),
          ),
          icon: Icon(
            _isExpanded
                ? Icons.arrow_drop_down_rounded
                : Icons.arrow_right_rounded,
            size: 65,
            color: Colors.white,
          ),
          label: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        if (!_isExpanded) const SizedBox(height: 12),
        if (_isExpanded)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Color(0xFF026c68),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.activities.map<Widget>((activity) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: '${activity['title']}: ',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(text: activity['description']),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
