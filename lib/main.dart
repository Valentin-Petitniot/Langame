import 'package:flutter/material.dart';
import 'package:langame/Routes/router.dart';

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
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),
            ),
            Icon(Icons.home),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text('Acceuil'),
          ],
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        width: MediaQuery.of(context).size.width / 2,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Acceuil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text('Liste'),
              onTap: () {
                Navigator.pushNamed(context, kListRoute);
              },
            )
          ],
        ),
      ),
      body: Container(
        color: Colors.black54,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
