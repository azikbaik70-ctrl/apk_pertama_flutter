import 'package:flutter/material.dart';
import 'user_streak.dart';

class StreakProvider  extends ChangeNotifier{
  UserStreak _streak = UserStreak(currentStreak: 3, highestStreak: 3);
  UserStreak get streak => _streak;

  void submitTask({required DateTime submissionTime, required DateTime deadline}) {
    if (submissionTime.isBefore(deadline) || submissionTime.isAtSameMomentAs(deadline)) {
      int newCurrent = _streak.currentStreak + 1;
      int newHighest = newCurrent > _streak.highestStreak ? newCurrent : _streak
          .highestStreak;

      _streak = _streak.copyWith(
        currentStreak: newCurrent,
        highestStreak: newHighest,
        lastSubmissionDate: submissionTime,
      );
    } else {
     _streak = _streak.copyWith(
     currentStreak: 0,
     lastSubmissionDate: submissionTime,
     );
    }
    notifyListeners();
  }
  }
