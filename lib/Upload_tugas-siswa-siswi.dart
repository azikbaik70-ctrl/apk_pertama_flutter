
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadTugas extends StatefulWidget {
  @override
  _UploadTugasState createState() => _UploadTugasState();
}
class _UploadTugasState extends State<UploadTugas> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _ambilFotoTugas() async {
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
    Future<void> _ambilDariGaleri() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch(e) {
      print("Error imge berasal dari Gallery: $e");
    }
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
              ? Image.file(_imageFile!, height: 200)
              : Text("Belum ada foto  yang  terpilih"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _ambilFotoTugas,
                child: Text('Ambil Dari Foto'),
              ),
              ElevatedButton(
                onPressed:  _ambilDariGaleri,
                child:  Text('Ambil Dari Galeri'),
              )
            ],
          )
        ),
      );
    }
  }
