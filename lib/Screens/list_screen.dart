import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:langame/Button/Modif_List_Button.dart';
import 'package:langame/Class/List_of_Words.dart';
import 'package:langame/Class/Word.dart';

import 'package:langame/Routes/router.dart';
import 'package:langame/Cards/List_Cards.dart';
import 'package:langame/Screens/Edit_List_Screen.dart';
import 'package:langame/Screens/New_List_Screen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<ListOfWord> data = [];
  bool refresh = false;
  Offset _tapPosition = Offset.zero;

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showContextMenu(BuildContext context, index) async {
    final RenderObject? overlay =
        Overlay.of(context)?.context.findRenderObject();

    final result = await showMenu(
      context: context,

      // Show the context menu at the tap location
      position: RelativeRect.fromRect(
          Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
              overlay.paintBounds.size.height)),

      // set a list of choices for the context menu
      items: [
        const PopupMenuItem(
          value: 'Supprimer',
          child: Text('Supprimer'),
        ),
      ],
    );

    // Implement the logic for each choice here
    switch (result) {
      case 'Supprimer':
        setState(() {
          data.removeAt(index);
        });
    }
  }

  Future<void> _navigatorAndDisplayListAdd(BuildContext context) async {

  }

  Future<void> _navigatorAndDisplayListEdit(BuildContext context, index) async {

  }

  Stream<List<ListOfWord>> readListWord() => FirebaseFirestore.instance
      .collection('List de mots')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ListOfWord.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        drawer: Drawer(
          width: MediaQuery.of(context).size.width / 2,
          child: ListView(
            children: [
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            refresh = false;
            _navigatorAndDisplayListAdd(context);
          },
          child: Icon(Icons.add),
        ),
        body: data.isNotEmpty
            ? Container(
                color: Colors.black54,
                width: double.infinity,
                height: double.infinity,
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTapDown: (details) => _getTapPosition(details),
                      onLongPress: () {
                        _showContextMenu(context, index);
                      },
                      child: ListCards(
                        name: data[index].name,
                        language: data[index].language,
                        child: ModifListButton(
                          onPressed: () {
                            refresh = false;
                            _navigatorAndDisplayListEdit(context, index);
                          },
                        ),
                      ),
                    );
                  },
                ),
              )
            : const Center(
                child: Text('Pas de liste enregistrer'),
              ));
  }
}
