import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:langame/Button/Add_Word_Button.dart';
import 'package:langame/Partials/Cards/List_Cards.dart';
import '../Model/List_of_Words.dart';
import '../Model/Word.dart';
import '../Partials/Cards/Input_Word.dart';

class EditListScreen extends StatefulWidget {
  const EditListScreen(
      {Key? key, required this.lists})
      : super(key: key);

  final ListOfWord lists;

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

final List<Widget> widgetWordList = [];
int num = 0;


class _EditListScreenState extends State<EditListScreen> {
  late  List<Word> _wordsList = [];

  /// Update the firebase document.
  /// If the list is empty, the methode add an object in the list
  /// to avoid problem in the firebase document
  Future editListWord({required String name, required String langue, required List<Word> wordList}) async {

    // Si la lite est vide, ajout d'un objet vide pour ne pas avoir de problème dans Firebase
    if (wordList.isEmpty)
    {
      wordList.add(Word.empty());
    }
    final docUser = FirebaseFirestore.instance.collection('list').doc(name);
    final listWords = ListOfWord(
      name: name,
      language: langue,
      words: wordList,
    );
    final json = listWords.toJson();

    await docUser.update(json);
  }

  @override
  void initState() {
    _wordsList = widget.lists.words!;
    num = _wordsList.length;
    super.initState();
  }

  Offset _tapPosition = Offset.zero;
  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showContextMenu(BuildContext context, int index) async {
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
          _wordsList.removeAt(index);
          num--;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 7),
              ),
              Icon(Icons.list),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Text('Modifier la Liste'),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: AddWordButton(
                  onPressed: () {
                    setState(
                      () {
                        num++;
                        _wordsList.add(Word.empty());
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black54,
          child: Column(
            children: [
              ListCards(name: widget.lists.name, language: widget.lists.language),
              Expanded(
                child: ListView.builder(
                  itemCount: num,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        onTapDown: (TapDownDetails details) => _getTapPosition(details),
                        onLongPress: () {
                          _showContextMenu(context, index);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: const BoxDecoration(
                            color: Colors.lightBlueAccent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                                child: SizedBox(
                                  height: 50,
                                  child: WordInput(
                                    hintText: 'Mot Original',
                                    label:  _wordsList[index].original,
                                    onChanged: (value){
                                      _wordsList[index].original = value;
                                      print('original: ' + _wordsList[index].original);
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(25, 5, 25, 0),
                                child: SizedBox(
                                  height: 50,
                                  child: WordInput(
                                    hintText: 'Mot Traduis',
                                    label: _wordsList[index].translate,
                                    onChanged: (value){
                                      _wordsList[index].translate = value;
                                      print('traduit: ' + _wordsList[index].translate);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            editListWord(name: widget.lists.name, langue: widget.lists.language, wordList: _wordsList);
            Navigator.pop(context);
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
