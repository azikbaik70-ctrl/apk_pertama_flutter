import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:apk_pertama/tugas_siswa.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget  {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Aplikasi SMPN 1 BOGOR',
      home: HalamanUtama(),
    );
  }
}

class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

 
  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}
class _HalamanUtamaState extends State<HalamanUtama> {
  int indexMenu = 0;

  int indexSubMenu = 0;

  final List<Map<String,dynamic>> dataMenu = [
    {
      "nama": "Guru",
      "subMenu": [
        {"nama": "Bapak Eka"}
      ],
    },
    {
      "nama": "Tugas",
      "subMenu":[ 
        {"nama": "IPA"},
        {"nama": "Mtk","detail": "tugas"},
        {"nama": "PAI","detail": "tugas"},
        {"nama": "PAK", "detail": "tugas"},
        {"nama": "PJOK", "detail": "tugas"},
        {"nama": "English", "detail": "tugas"},
        {"nama": "B.indonesia", "detail": "tugas"},
        {"nama":"IPS", "detail": "tugas"},
        {"nama": "Seni Budaya", "detail": "tugas"},
        {"nama": "B.Sunda", "detail": "tugas"},
      ],
    },
    {
      "nama": "Materi yang di pelajarin",
      "subMenu": [
        {"nama": "Ipa"},
      ],
    },
    {
      "nama": "Catatan Semua Mapel",
      "subMenu": [
        {"nama": "mtk"},
      ],
    },
    {
      "nama": "Siswa-siswi",
      "subMenu":[
        {"nama": "aziq"},
      ] ,
       },
  ];

  @override
  Widget build(BuildContext context) {
    final List<dynamic> subMenuRaw = dataMenu[indexMenu]["subMenu"];

        if(indexSubMenu >= subMenuRaw.length) {
          indexSubMenu = 0;
        }

   return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 11.0, sigmaY: 11.0),
            child: AppBar(
              
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                
                children: [
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                      
                    ),
                  ),
                  SizedBox(width: 14),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.4),
                      shape:  BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 14),
                  
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 14),
                    const Text(
                    'SMP Negeri 1 Bogor',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19,),
                  )
                ],
              ),
        backgroundColor: Colors.grey.withValues(alpha: 0.2),
        foregroundColor: Colors.black,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.withValues(alpha: 0.2),
            height: 1.0,
          ),
        )
      ),
            ),
          ),
        ),
        
      body:  Row(
        children: [
          SizedBox(
            width: 44,
            child: Container(
              color: Colors.black.withValues(alpha: 0.8),
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.co_present),
                    color: indexMenu == 0
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.4),
                    iconSize: 24,
                    onPressed: () {
                      setState(() {
                        indexMenu = 0;
                        indexSubMenu = 0;
                      });
                    }
                  ),
                  const SizedBox(height: 15),
                  IconButton(
                    icon: const Icon(Icons.edit_note),
                    color:  indexMenu == 1
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.4),
                    iconSize: 24,
                    onPressed: () {
                      setState(() {
                        indexMenu = 1;
                        indexSubMenu = 0;
                      });
                    }
                  ),
                  const SizedBox(height: 15),
                  IconButton(
                    icon: const Icon(Icons.menu_book),
                    color: indexMenu == 2
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.4),
                    iconSize: 24,
                    onPressed: () {
                      setState(() {
                        indexMenu = 2;
                        indexSubMenu = 0;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  IconButton(
                    icon: const Icon(Icons.assignment),
                    color: indexMenu == 3
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.4),
                    iconSize: 24,
                    onPressed: ()  {
                      setState(() {
                        indexMenu = 3;
                        indexSubMenu = 0;
                      });
                    }
                  ),
                  const SizedBox(height: 15),
                  IconButton(
                    icon: const Icon(Icons.person),
                    color: indexMenu == 4
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.4),
                    iconSize: 24,
                    onPressed: () {
                      setState(() {
                        indexMenu = 4;
                        indexSubMenu = 0;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.purple,
              child: ListView.builder(
                itemCount: subMenuRaw.length,
                itemBuilder: (context, index) {
                  return Material(
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                       subMenuRaw[index]["nama"] ?? "",
                      style: const TextStyle(color: Colors.white),
                    ),
                     tileColor: indexSubMenu == index ? Colors.purpleAccent : Colors.transparent,
                     splashColor: Colors.white.withValues(alpha: 0.3),
                     hoverColor: Colors.white.withValues(alpha:0.1),
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
            child: indexMenu == 1
                ? const TugasSiswa()
                : Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail ${dataMenu[indexMenu]["nama"]}:",
                    style: const TextStyle(fontSize: 14, color:  Colors.grey, fontWeight: FontWeight.bold),

                  ),
                  const SizedBox(height: 10),
                  Text(
                    subMenuRaw[indexSubMenu]["nama"] ?? "",
                    style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.purple),

                  ),
                  const SizedBox(height: 10),
                  Text(
                   subMenuRaw[indexSubMenu]["detail"] ?? "Tidak ada deksripsi.",
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  )
                ],
                ),
              ),
            ),
        ]
      ),
    );
  }
}
        
       
       