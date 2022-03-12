import 'package:flutter/material.dart';

import 'package:custom_panel/widgets/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Panel',
      theme: ThemeData(primarySwatch: Colors.purple),
      darkTheme: ThemeData(
          primarySwatch: Colors.purple,
          backgroundColor: Colors.black45,
          brightness: Brightness.dark,
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 60, 43, 63))),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
