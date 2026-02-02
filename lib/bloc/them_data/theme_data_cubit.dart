import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
part 'theme_data_state.dart';

class ThemeDataCubit extends Cubit<ThemeDataState> {
  ThemeDataCubit() : super(ThemeDataLight());

  void toogleLightTheme() {
    emit(ThemeDataLight());
  }

  void toogleDarkTheme() {
    emit(ThemeDataDark());
  }

  void toogleTheme() {
    if (state is ThemeDataLight) {
      emit(ThemeDataDark());
    } else {
      emit(ThemeDataLight());
    }
  }
}
