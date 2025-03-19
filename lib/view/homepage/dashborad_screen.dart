import 'dart:io';

import 'package:attendance_app/core/image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class DashboradScreen extends StatefulWidget {
  const DashboradScreen({super.key});

  @override
  State<DashboradScreen> createState() => _DashboradScreenState();
}

File? imageResult;

class _DashboradScreenState extends State<DashboradScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: ElevatedButton(
                  onPressed: () {
                    pickImage();
                    debugPrint('hasil gambar dari pick image: $imageResult');
                  },
                  child: Text('Input Image'))),
          Container(
            width: size.width * 0.5,
            height: size.height * 0.5,
            child: imageResult != null
                ? Image.file(imageResult!)
                : const Text('No Image Selected'),
          ),
          ElevatedButton(
              onPressed: () {
                uploadImage();
                debugPrint('hasil gambar dari pick image: $imageResult');
              },
              child: Text('Kirim Image')),
          ElevatedButton(
              onPressed: () {
                pickImage();
                debugPrint('hasil gambar dari pick image: $imageResult');
              },
              child: Text('Cocokan Image')),
          SizedBox(
            height: 10,
          ),
          Text('Status : $imageResult')
        ],
      ),
    );
  }

  Future<File> pickImage() async {
    String? imageSelect = await ImagePickers().pickImage();
    if (imageSelect != '') {
      setState(() {
        imageResult = File(imageSelect);
      });
    }

    final Directory tempDir = await getTemporaryDirectory();
    final File tempFile = File('${tempDir.path}/temp_image.jpg');

    final File savedFile = await File(imageResult!.path).copy(tempFile.path);

    return savedFile;
  }

  Future<void> uploadImage() async {
    if (imageResult == null) {
      print("Gambar belum dipilih");
      return;
    }

    var stream = http.ByteStream(Stream.castFrom(imageResult!.openRead()));
    var length = await imageResult!.length();
   final uri = Uri.parse("http://192.168.1.57:8080/api/upload");


    var request = http.MultipartRequest("POST", uri);
    request.files.add(http.MultipartFile("image", stream, length,
        filename: basename(imageResult!.path)));

    var response = await request.send();
    if (response.statusCode == 200) {
      print("Gambar berhasil diunggah ${response.statusCode}");
    } else {
      print("Gagal mengunggah gambar");
    }
  }
}
