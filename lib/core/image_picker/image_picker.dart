import 'package:image_picker/image_picker.dart';

class ImagePickers {
  final imagePicker = ImagePicker();
  Future<String> pickImage() async{
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    final lostResponseData = await imagePicker.retrieveLostData();
    if (pickedFile != null) {
      return pickedFile.path;
    } else if (lostResponseData.file != null){
      return lostResponseData.file!.path;
    } else {
      return '';
    }
  }


   Future<String> pickCamera() async{
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera,imageQuality:40 );
    final lostResponsedata = await imagePicker.retrieveLostData();
    if (lostResponsedata.file != null) {
      return lostResponsedata.file!.path;
    } else if (pickedFile != null){ 
      return pickedFile.path;
    } else {
      return '';
    }
  }



}