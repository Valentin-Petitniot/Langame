import 'package:flutter/material.dart';
import 'package:langame/Class/List_of_Words.dart';

import 'package:langame/Routes/router.dart';
import 'package:langame/main.dart';
import 'package:langame/Screens/list_screen.dart';
import 'package:langame/Screens/Edit_List_Screen.dart';
import 'package:langame/Screens/View_Words_List_Screen.dart';

ListOfWord test = ListOfWord(name: 'defaut');

Map<String, WidgetBuilder> router = {
  kHomeRoute: (context) => MyApp(),
  kListRoute: (context) => const ListScreen(),
  kEditRoute: (context) =>  EditListScreen(test: test),
  kViewWordList: (context) => const ViewWordsListScreen(),
};