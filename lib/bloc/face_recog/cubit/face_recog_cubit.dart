import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'face_recog_state.dart';

class FaceRecogCubit extends Cubit<FaceRecogState> {
  FaceRecogCubit() : super(FaceRecogInitial());

  void sendImages() {
    //mengirim data gambar ke database untuk di proses

    try {} catch (e) {
      emit(FaceRecogErr());
    }
  }
}
