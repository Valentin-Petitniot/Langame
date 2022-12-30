import 'package:flutter/material.dart';
import 'package:langame/Routes/router.dart';
import 'package:langame/Screens/list_screen.dart';

import 'Routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Langame';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: router,
      initialRoute: kListRoute,
      title: appTitle,
      home: const ListScreen(),
    );
  }
}
