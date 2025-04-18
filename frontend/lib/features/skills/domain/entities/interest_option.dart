enum InterestOption { corrida, musculacao, leitura, meditacao }

extension InterestOptionExtension on InterestOption {
  String jsonPath(InterestOption interestOptionSelected) {
    switch (this) {
      case InterestOption.corrida:
        return 'assets/data/interest_run_data.json';
      case InterestOption.musculacao:
        return 'assets/data/interest_gym_data.json';
      case InterestOption.leitura:
        return 'assets/data/interest_reading_data.json';
      case InterestOption.meditacao:
        return 'assets/data/interest_meditation_data.json';
    }
  }

  String iconPath(InterestOption interestOptionSelected) {
    switch (this) {
      case InterestOption.corrida:
        return 'assets/icon/runner_icon.png';
      case InterestOption.musculacao:
        return 'assets/icon/weight_gym_icon.png';
      case InterestOption.leitura:
        return 'assets/icon/read_book_icon.png';
      case InterestOption.meditacao:
        return 'assets/icon/meditation_icon.png';
    }
  }
}
