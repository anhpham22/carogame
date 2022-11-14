class PlayProgressState {
  final int initLeLevel;
  final int levelHighestReached;

  PlayProgressState(
      {required this.initLeLevel, required this.levelHighestReached});

  PlayProgressState copyWith({
    int? initLeLevel,
    int? levelHighestReached,
  }) {
    return PlayProgressState(
        initLeLevel: initLeLevel ?? this.initLeLevel,
        levelHighestReached: levelHighestReached ?? this.levelHighestReached);
  }
}

enum PlayProgressStatus { initial, success, failure }
