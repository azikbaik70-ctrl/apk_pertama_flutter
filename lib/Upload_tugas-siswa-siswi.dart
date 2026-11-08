
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadTugas extends StatefulWidget {
  const UploadTugas({super.key});

  @override
  State<UploadTugas> createState() => _UploadTugasState();
}
class _UploadTugasState extends State<UploadTugas> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _ambilFotoTugas(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
       print("Error picking image: $e");
      }
    }
    void _tampilkanPilihanSumber() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
        builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget> [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Pilih Sumber Foto Tugas',
                  style: TextStyle(fontSize:  18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: Icon(Icons.photo_camera,  color: Colors.blue),
                title: Text('Kamera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _ambilFotoTugas(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library,  color: Colors.blue),
                title: Text('Galeri'),
                onTap: () {
                  Navigator.of(context).pop();
                  _ambilFotoTugas(ImageSource.gallery);
                },
              ),
            ],
          )
        );
      },
    );
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text('Upload Tugas')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageFile !=null
              ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(_imageFile!, height: 250,width: 250, fit: BoxFit.cover),
          )
         : Container(
          height: 250,
          width: 250,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.image, size: 80, color: Colors.grey),
      ),
              SizedBox(height: 30),

                ElevatedButton.icon(
                  onPressed: _tampilkanPilihanSumber,
                  icon: Icon(Icons.add_a_photo),
                  label: Text('Pilih Foto Tugas'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
            ],
          ),
        ),
      );
    }
  }
