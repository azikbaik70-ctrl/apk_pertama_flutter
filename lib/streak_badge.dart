import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'streak_provider.dart';

class Streakbadge extends StatelessWidget {
  const Streakbadge({Key? key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final streakData = context.watch<StreakProvider>().streak;
    final bool isStreakActive = streakData.currentStreak > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, py: 6),
    )
  }
}