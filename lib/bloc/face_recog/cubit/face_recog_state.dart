part of 'face_recog_cubit.dart';

@immutable
sealed class FaceRecogState {}

final class FaceRecogInitial extends FaceRecogState {}

final class FaceRecogsucces extends FaceRecogState {
  final String? result;
  FaceRecogsucces({this.result});
}

final class FaceRecogErr extends FaceRecogState {}
