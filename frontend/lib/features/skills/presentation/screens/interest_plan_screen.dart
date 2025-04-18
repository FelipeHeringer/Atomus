import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/features/skills/presentation/widget/interest_navigation_buttons.dart';
import 'package:frontend/features/skills/presentation/widget/interest_phase_button.dart';
import 'package:frontend/features/skills/presentation/widget/interest_plan_header.dart';

class InterestPlanScreen extends StatefulWidget {
  const InterestPlanScreen({super.key});

  @override
  State<InterestPlanScreen> createState() => InterestPlanScreenState();
}

class InterestPlanScreenState extends State<InterestPlanScreen> {
  late Map<String, dynamic> jsonData;
  late String jsonPath;
  late String iconPath;
  Map<String, dynamic>? activities;
  bool _hasLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_hasLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map<String,String>) {
        jsonPath = args['jsonPath'] ?? '';
        iconPath = args['iconPath'] ?? '';
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
              iconPath : iconPath,
              title: jsonData['title'],
              description: jsonData['description'],
            ),
            const SizedBox(height: 26),
            InterestNavigationButtons(onStart: () {}),
            const SizedBox(height: 20),
            InterestPhaseButton(
              phaseTitle: jsonData['phase_1']['title'],
              weeksData: jsonData['phase_1'],
            ),
            InterestPhaseButton(
              phaseTitle: jsonData['phase_2']['title'],
              weeksData: jsonData['phase_2'],
            ),
            InterestPhaseButton(
              phaseTitle: jsonData['phase_3']['title'],
              weeksData: jsonData['phase_3'],
            ),
            InterestPhaseButton(
              phaseTitle: jsonData['phase_4']['title'],
              weeksData: jsonData['phase_4'],
            ),
          ],
        ),
      ),
    );
  }
}
