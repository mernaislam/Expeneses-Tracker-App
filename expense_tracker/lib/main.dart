import 'package:expense_tracker/widgets/expenses.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 10, 36, 19),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 64, 63),
);

void main() {
// For locking device orientation: 
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp],
  // ).then(
  //   (fn) {
      return runApp(
        MaterialApp(
          darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            colorScheme: kDarkColorScheme,
            cardTheme: const CardTheme().copyWith(
              color: kDarkColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kDarkColorScheme.secondaryContainer,
                foregroundColor: kDarkColorScheme.onSecondaryContainer,
              ),
            ),
          ),
          theme: ThemeData().copyWith(
            useMaterial3: true,
            colorScheme: kColorScheme,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kColorScheme.onPrimaryContainer,
              foregroundColor: kColorScheme.onPrimary,
            ),
            cardTheme: const CardTheme().copyWith(
              color: kColorScheme.secondaryContainer,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: kColorScheme.secondaryContainer,
              ),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: kColorScheme.onSecondaryContainer,
                  ),
                ),
          ),
          debugShowCheckedModeBanner: false,
          home: const Expenses(),
        ),
      );
  //   },
  // );
}
