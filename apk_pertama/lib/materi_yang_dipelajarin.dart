import 'package:flutter/material.dart';

class materiYangDipelajarin extends StatefulWidget {
  const materiYangDipelajarin({super.key});

  @override
  State<materiYangDipelajarin> createState() => _materiYangDipelajarinState();
}

class _materiYangDipelajarinState extends State<materiYangDipelajarin> {
  int indexSubMenu = 0;

  final List<Map<String, dynamic>> subMenuMateri = [
    {"nama": "Senin", "rangkuman": "materi"},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.purple,
            child: ListView.builder(
              itemCount: subMenuMateri.length,
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: ListTile(
                    title: Text(
                      subMenuMateri[index]["nama"] ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                    tileColor: indexSubMenu == index
                        ? Colors.purpleAccent
                        : Colors.transparent,
                    splashColor: Colors.white.withValues(alpha: 0.3),
                    hoverColor: Colors.white.withValues(alpha: 0.1),
                    selected: indexSubMenu == index,
                    onTap: () {
                      setState(() {
                        indexSubMenu = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Detail Materi:",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subMenuMateri[indexSubMenu]["nama"] ?? "",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  subMenuMateri[indexSubMenu]["rangkuman"] ??
                      "Tidak ada deksripsi.",
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
