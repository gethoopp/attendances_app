extension StringValidate on String? {
  String? get validateEmail {
    if (this == null) {
      return null;
    }

    if (this!.isEmpty) {
      return "Email tidak boleh kosong";
    }

    if (this!.length < 6) {
      return "Masukkan email dengan benar";
    }



    return null;
  }


  String? get validatePassword {
    if (this == null) {
      return null;
    }

    if (this!.isEmpty) {
      return "Password tidak boleh kosong";
    }

    if (this!.length < 5) {
      return "Password harus lebih dari 5 karakter";
    }

    return null;
  }


  String? get validateConfirmPassword {
    if (this == null) {
      return null;
    }

    if (this!.isEmpty) {
      return "Password tidak boleh kosong";
    }

    if (this!.length != validatePassword!.length) {
      return "Password tidak sama";
      
    }

     if (this != validatePassword) {
      return "Password tidak sama";
      
    }

    return null;
  }
}
