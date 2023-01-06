import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:langame/Routes/router.dart';
import 'package:langame/Screens/list_screen.dart';
import 'Routes/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static const appTitle = 'Langame';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: router,
      title: appTitle,
      home: const ListScreen(),
    );
  }
}
