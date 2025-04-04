extension StringValidate on String? {
  String? get validateEmail {
    if (this == null) {
      return null;
    }

    // if (this!.isEmpty) {
    //   return "Email tidak boleh kosong";
    // }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
        .hasMatch(this!)) {
      return "Format email tidak valid";
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

    // Uncomment the following lines to check for empty password
    // if (this!.isEmpty) {
    //   return "Password tidak boleh kosong";
    // }

    if (this!.length < 5) {
      return "Password harus lebih dari 5 karakter";
    }

    return null;
  }

  String? get validateRfid {
    if (this == null) {
      return null;
    }

    // Check if validatePassword is null
    if (this == null) {
      return "RFID tidak boleh kosong";
    }
    return null;
  }

  String? validateFirstName(int? minLength, int? maxLength) {
    if (this == null) {
      return null;
    }

    if (this!.isEmpty) {
      return "Nama Pengguna Minimal $minLength Karakter";
    }

    if (this!.length > maxLength!) {
      return "Nama Pengguna Maksimal $maxLength Karakter";
    }

    if (this!.contains(RegExp(r'\d'))) {
      return "Nama Pengguna tidak boleh mengandung angka";
    }
    if (this!.contains(RegExp(r'[@!#\$%^&*(),.?":{}|<>]'))) {
      return "Nama Pengguna tidak boleh mengandung simbol";
    }

    if (this!.contains(RegExp(r'^[0-9]'))) {
      return "Nama Pengguna tidak boleh diawali dengan angka";
    }
    if (this!.contains(RegExp(r'^[A-Z]'))) {
      return "Nama Pengguna harus diawali dengan huruf kecil";
    }
    if (this!.contains(RegExp(r'^[!@#\$%^&*(),.?":{}|<>]'))) {
      return "Nama Pengguna tidak boleh diawali dengan simbol";
    }

    return null;
  }

  String? validateLastName(int? minLength, int? maxLength) {
    if (this == null) {
      return null;
    }

    if (this!.isEmpty) {
      return "Nama Pengguna Minimal $minLength Karakter";
    }

    if (this!.length > maxLength!) {
      return "Nama Pengguna Maksimal $maxLength Karakter";
    }

    if (this!.contains(RegExp(r'\d'))) {
      return "Nama Pengguna tidak boleh mengandung angka";
    }
    if (this!.contains(RegExp(r'[@!#\$%^&*(),.?":{}|<>]'))) {
      return "Nama Pengguna tidak boleh mengandung simbol";
    }

    if (this!.contains(RegExp(r'^[0-9]'))) {
      return "Nama Pengguna tidak boleh diawali dengan angka";
    }
    if (this!.contains(RegExp(r'^[A-Z]'))) {
      return "Nama Pengguna harus diawali dengan huruf kecil";
    }
    if (this!.contains(RegExp(r'^[!@#\$%^&*(),.?":{}|<>]'))) {
      return "Nama Pengguna tidak boleh diawali dengan simbol";
    }

    return null;
  }
}
