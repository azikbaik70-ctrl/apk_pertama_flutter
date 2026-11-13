class UserStreak {
  final int currentStreak;
  final int highestStreak;
  final DateTime? lastSubmissionDate;

  UserStreak({
    required this.currentStreak,
    required this.highestStreak,
    this.lastSubmissionDate,
  });

  UserStreak copyWith({
    int? currentStreak,
    int? highestStreak,
    DateTime? lastSubmissionDate,
  }) {
    return UserStreak(
      currentStreak: currentStreak ?? this.currentStreak,
      highestStreak: highestStreak ?? this.highestStreak,
      lastSubmissionDate: lastSubmissionDate ?? this.lastSubmissionDate,
    );
  }
}
