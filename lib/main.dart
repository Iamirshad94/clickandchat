import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClickAndChat',
      theme: ThemeData().copyWith(
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.lightBlueAccent,
        ),
        scaffoldBackgroundColor: Colors.white,
        errorColor: Colors.red,
        colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black12),
        cursorColor: Colors.lightBlueAccent,
        textTheme: const TextTheme(
          subtitle1: TextStyle(color: Colors.white70),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
