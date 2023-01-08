import 'package:flutter/material.dart';

import 'package:langame/Routes/router.dart';
import 'package:langame/main.dart';
import 'package:langame/Screens/list_screen.dart';



Map<String, WidgetBuilder> router = {
  kHomeRoute: (context) => MyApp(),
  kListRoute: (context) => const ListScreen(),
};