import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:langame/Button/Modif_List_Button.dart';
import 'package:langame/Partials/Cards/List_Cards.dart';
import 'package:langame/Screens/Edit_List_Screen.dart';
import 'package:langame/Screens/New_List_Screen.dart';
import 'package:langame/Screens/View_Words_List_Screen.dart';
import '../Model/List_of_Words.dart';


class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Offset _tapPosition = Offset.zero;

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showContextMenu(BuildContext context, String docName) async {
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
          DeleteListWord(name: docName);
        });
    }
  }

  Future DeleteListWord({required String name}) async {
    final docUser = FirebaseFirestore.instance.collection('list').doc(name);
    await docUser.delete();
  }

  Future<void> _navigatorAndDisplayListAdd(BuildContext context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewListScreen(),
        ));
  }

  Future<void> _navigatorAndDisplayList(BuildContext context, ListOfWord list) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ViewWordsListScreen(listOfWord: list)));
  }

  Future<void> _navigatorAndDisplayListEdit(BuildContext context, ListOfWord list) async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditListScreen(lists: list)));
  }

  Stream<List<ListOfWord>> readListWord() => FirebaseFirestore.instance
      .collection('list')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => ListOfWord.fromJson(doc.data())).toList());

  Widget buildLists(ListOfWord lists) => InkWell(
    onTap: (){
          _navigatorAndDisplayList(context, lists);
        },
    onTapDown: (TapDownDetails details) => _getTapPosition(details),
    onLongPress: () {
      _showContextMenu(context, lists.name);
    },
    child: ListCards(
      name: lists.name,
      language: lists.language,
      child: ModifListButton(
            onPressed: () {
              _navigatorAndDisplayListEdit(context, lists);
            },
          ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.list),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text('Listes de mots'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigatorAndDisplayListAdd(context);
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<ListOfWord>>(
        stream: readListWord(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong! ${snapshot.error.toString()}');
          } else if (snapshot.hasData) {
            final lists = snapshot.data!;
            return ListView(
              children: lists.map(buildLists).toList(),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
