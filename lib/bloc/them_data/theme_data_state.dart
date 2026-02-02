part of 'theme_data_cubit.dart';

abstract class ThemeDataState {
  final ThemeData themeData;
  const ThemeDataState(this.themeData);
}

final class ThemeDataLight extends ThemeDataState {
  ThemeDataLight()
    : super(
        ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey.shade200,
          canvasColor: Colors.black,

          colorScheme: ThemeData.light().colorScheme.copyWith(
            primary: Colors.grey.shade200,
            surface: Colors.white54,
            surfaceContainer: Colors.grey.shade200,
            onSecondaryContainer: Colors.grey.shade300,
            surfaceTint: Colors.blueAccent,
          ),
        ),
      );
}

final class ThemeDataDark extends ThemeDataState {
  ThemeDataDark()
    : super(
        ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(43, 117, 114, 114),
          canvasColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.yellow),
          colorScheme: ThemeData.dark().colorScheme.copyWith(
            primary: Colors.blue,
            surface: Colors.black,
            onSecondaryContainer: Colors.black,
            surfaceContainer: Colors.black,
            surfaceTint: Colors.blueAccent,
          ),
        ),
      );
}
