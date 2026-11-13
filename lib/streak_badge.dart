import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'streak_provider.dart';

class Streakbadge extends StatelessWidget {
  const Streakbadge({Key?  key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final streakData = context.watch<StreakProvider>().streak;
    final bool isStreakActive = streakData.currentStreak > 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isStreakActive ? Colors.orange.withOpacity(0.15) : Colors.grey.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: isStreakActive ? Colors.orange : Colors.grey,
        width: 1.5,
      ),
      ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(
    Icons.local_fire_department_rounded,
    color: isStreakActive ? Colors.deepOrange : Colors.grey,
    size: 24,
    ),
    const SizedBox(width:4),
    Text(
    '${streakData.currentStreak}',
    style: TextStyle(
     color: isStreakActive ? Color.fromRGBO(255, 140, 0, 1.0) : Colors.grey[700],
    fontWeight: FontWeight.bold,
    fontSize: 15,
    ),
    ),
    ],
    ),
    );
  }
}