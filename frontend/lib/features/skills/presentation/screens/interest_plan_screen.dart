import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/features/skills/presentation/widget/interest_navigation_buttons.dart';
import 'package:frontend/features/skills/presentation/widget/interest_plan_header.dart';
import 'package:google_fonts/google_fonts.dart';

class InterestPlanScreen extends StatefulWidget {
  const InterestPlanScreen({super.key});

  @override
  State<InterestPlanScreen> createState() => InterestPlanScreenState();
}

class InterestPlanScreenState extends State<InterestPlanScreen> {
  late Map<String, dynamic> jsonData;
  late String jsonPath;
  bool _selectedPhase = false;
  bool _selectedWeek = false;
  bool _hasLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is String) {
        jsonPath = args;
        _loadJson();
        _hasLoaded = true;
      } else {
        print('Invalid argument passed to InterestPlanScreen');
      }
    }
  }

  Future<void> _loadJson() async {
    try {
      final String response = await rootBundle.loadString(jsonPath);
      final data = json.decode(response);
      setState(() {
        jsonData = data;
      });
    } catch (e) {
      print("Error loading JSON: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_hasLoaded || jsonData.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            InterestPlanHeader(
              title: jsonData['title'],
              description: jsonData['description'],
            ),
            const SizedBox(height: 26),
            InterestNavigationButtons(onStart: () {}),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedPhase = !_selectedPhase;
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
                jsonData['phase_1']['title'],
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (_selectedPhase) ...[
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _selectedWeek = !_selectedWeek;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1C988B),
                      minimumSize: const Size(363, 65),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    label: Text(
                      jsonData['phase_1']['week_1']['title'],
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    icon:
                        _selectedWeek
                            ? const Icon(
                              Icons.arrow_drop_down_rounded,
                              size: 65,
                              color: Colors.white,
                            )
                            : const Icon(
                              Icons.arrow_right_rounded,
                              size: 65,
                              color: Colors.white,
                            ),
                  ),
                  if (_selectedWeek)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF026c68),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8), 
                          bottomRight: Radius.circular(8)
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            jsonData['phase_1']['week_1']['activities']
                                .map<Widget>((activity) {
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
                                          TextSpan(
                                            text: activity['description'],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                                .toList(),
                      ),
                    ),
                ],
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text('week 2 - Json Fase 1'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text('week 3 - Json Fase 1'),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: const Text('week 4 - Json Fase 1'),
              ),
            ],
            ElevatedButton(onPressed: () {}, child: Text('Json Fase 2')),
            ElevatedButton(onPressed: () {}, child: Text('Json Fase 3')),
            ElevatedButton(onPressed: () {}, child: Text('Json Fase 4')),
          ],
        ),
      ),
    );
  }
}
