import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'streak_provider.dart';
import 'streak_badge.dart';
import 'tugas_siswa.dart';

class StreakDashboard  extends StatelessWidget{
  const StreakDashboard({Key? key }) : super(key: key);

   void _showStreakPopup(BuildContext context, int currentStreak) {
     showDialog(
       context: context,
       builder: (context) => AlertDialog(
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
         title: const Text('🔥 LUAR BIASA', textAlign: TextAlign.center),
         content: Column(
         mainAxisSize: MainAxisSize.min,
           children: [
             const Icon(Icons.local_fire_department_rounded, size: 82, color: Colors.orange),
             const SizedBox(height: 16),
             Text(
               'Kamu berhasil mempertahankan Streak kamu selama $currentStreak hari!',
               textAlign: TextAlign.center,
               style: const TextStyle(fontSize: 15),
             )
           ],
         ),
         actions: [
           TextButton(
             onPressed: () => Navigator.pop(context),
             child: const Text('Lanjutkan'),
           )
         ],
       ),
     );
   }
   @override
  Widget Build(BuildContext context) {
     final provider = context.read<StreakProvider>();

     return  Scaffold(
       appBar: AppBar(
         title: const Text('Tugas & Streak'),
         actions: const [
           Padding(
             padding: EdgeInsets.only(right: 16.0),
             child: Center(child: Streakbadge()),
           )
         ],
       ),
       body: Padding(
         padding: const EdgeInsets.all(20.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             Card(
               elevation: 4,
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                   child: Column(
                   children: [
                     const Text('Daftar Tugas'),
                     ...masterDaftarTugas.map((Item) => Text(Item)),
                 ],
               )
               ),
             )
           ],
         )
       )
     )
   }
  }
}