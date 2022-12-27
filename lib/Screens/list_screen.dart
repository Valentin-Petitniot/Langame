import 'package:flutter/material.dart';

import 'package:langame/Routes/router.dart';
import 'package:langame/Cards/Add_Word_Card.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

List<Widget> bodyElement = [];
int num = 0;

void addBodyElement(){
  bodyElement.add(
    const AddWordCard()
  );
}

class _ListScreenState extends State<ListScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 6),
              ),
              Icon(Icons.list),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Text('Listes de mots'),
            ],
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            num++;
            setState(() {
              addBodyElement();
            });
          },
          backgroundColor: Colors.deepPurpleAccent,
          tooltip: 'Ajout de Liste',
          label: Icon(Icons.add),
          shape: CircleBorder(
            side: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width / 2,
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Acceuil'),
                onTap: () {
                  Navigator.pushNamed(context, kHomeRoute);
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text('Listes'),
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
          child: ListView(
            children: <Widget>[
              Column(
                children: bodyElement,
              )
            ],
          ),
        ),
      ),
    );
  }
}
