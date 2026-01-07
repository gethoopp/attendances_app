import 'package:attendance_app/repository/faceRecog/base_images.dart';
import 'package:dio/dio.dart';

class FaceRecognition implements BaseImageRepository {
  final dio = Dio();
  @override
  Future<void> sendImages() {
    //mengirim data gambar ke database untuk di proses
    throw UnimplementedError();
  }

  @override
  Future<void> getImages() {
    //mengambil data gambar dari database
    throw UnimplementedError();
  }
}
