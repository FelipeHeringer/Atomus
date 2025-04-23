import 'package:flutter/material.dart';
import 'package:frontend/features/skills/domain/entities/interests_option.dart';
import 'package:frontend/features/skills/presentation/widget/_button.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillsProfileScreen extends StatefulWidget {
  const SkillsProfileScreen({super.key});
  
  @override
  createState() => SkillsProfileScreenState();
}

class SkillsProfileScreenState extends State<SkillsProfileScreen> {

  void _onSkillPressed(InterestOption skillSelected){
    String jsonPath = catchTheJsonPath(skillSelected);
    String iconPath = catchTheSkillIconPath(skillSelected);
    Navigator.pushNamed(context, '/interest_plan', arguments: {'jsonPath': jsonPath, 'iconPath': iconPath});
  }

  String catchTheJsonPath(InterestOption skillSelected){
    return skillSelected.jsonPath(skillSelected);
  }

  String catchTheSkillIconPath(InterestOption skillSelected){
    return skillSelected.iconPath(skillSelected);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Escolha seu interesse",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Color(0xFFFFFFFF),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            Text(
              "Escolha o hobbie ou atividade que deseja desevolver, e vamos entregar um plano para você!",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Color(0xFFFFFFFF),
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 63),
            SkillsButtons(iconString: 'assets/icon/runner_icon.png', hint: "Corrida", width: 320, height: 50, onPressed: () => _onSkillPressed(InterestOption.corrida)),
            const SizedBox(height: 10),
            SkillsButtons(iconString: 'assets/icon/weight_gym_icon.png', hint: "Musculação", width: 320, height: 50, onPressed: () => _onSkillPressed(InterestOption.musculacao)),
            const SizedBox(height: 10),
            SkillsButtons(iconString: 'assets/icon/read_book_icon.png', hint: "Leitura", width: 320, height: 50, onPressed: () => _onSkillPressed(InterestOption.leitura)),
            const SizedBox(height: 10),
            SkillsButtons(iconString: 'assets/icon/meditation_icon.png', hint: "Meditação", width: 320, height: 50, onPressed: () => _onSkillPressed(InterestOption.meditacao)),
            const SizedBox(height: 40),
            SkillsButtons(hint: "Personalizado", width: 188, height: 41, onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

