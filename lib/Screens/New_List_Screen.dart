import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:langame/Button/Add_Word_Button.dart';
import 'package:langame/Model/List_of_Words.dart';
import '../Model/Word.dart';
import '../Partials/Cards/Input_Word.dart';

const List<String> lgList = <String>['Langue', 'En', 'Fr', 'Nl', 'De'];

class NewListScreen extends StatefulWidget {
  const NewListScreen({Key? key}) : super(key: key);

  @override
  State<NewListScreen> createState() => _NewListScreenState();
}

final List<Widget> widgetWordList = [];
int num = 0;

class _NewListScreenState extends State<NewListScreen> {
  TextEditingController nameCtrl = TextEditingController();
  late String languageCtrl;
  final List<Word> _wordsList = [];

  String dropDownValue = lgList.first;

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
                    left: MediaQuery.of(context).size.width / 6),
              ),
              Icon(Icons.list),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Text('Nouvelle la Liste'),
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
          color: Colors.black38,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: DropdownButton<String>(
                  value: dropDownValue,
                  icon: const Icon(Icons.arrow_downward),
                  elevation: 16,
                  style: const TextStyle(color: Colors.white),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? value) {
                    setState(
                      () {
                        dropDownValue = value!;

                        switch (dropDownValue) {
                          case 'En':
                            languageCtrl = 'Anglais';
                            print('Anglais s??l??ctionn??');
                            break;
                          case 'Fr':
                            languageCtrl = 'Fran??ais';
                            print(languageCtrl + ' s??l??ctionn??');
                            break;
                          case 'Nl':
                            languageCtrl = 'N??erlandais';
                            break;
                          case 'De':
                            languageCtrl = 'Allemand';
                            break;
                        }
                      },
                    );
                  },
                  dropdownColor: Colors.black,
                  items: lgList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: nameCtrl,
                      autocorrect: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        var newValue = value ?? "";
                        if (newValue.isEmpty) {
                          return 'title is required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: num,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        onTapDown: (TapDownDetails details) =>
                            _getTapPosition(details),
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
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    child: SizedBox(
                                      width: 250,
                                      height: 50,
                                      child: WordInput(
                                        hintText: 'Mot Original',
                                        onChanged: (value) {
                                          _wordsList[index].original = value;
                                          print('original: ' +
                                              _wordsList[index].original);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: SizedBox(
                                      width: 250,
                                      height: 50,
                                      child: WordInput(
                                        hintText: 'Mot Traduis',
                                        onChanged: (value) {
                                          _wordsList[index].translate = value;
                                          print('traduit: ' +
                                              _wordsList[index].translate);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )
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
            num = 0;
            createListWord(
                name: nameCtrl.text,
                langue: languageCtrl,
                wordList: _wordsList);
            widgetWordList.clear();
            Navigator.pop(context);
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }

  Future createListWord(
      {required String name,
      required String langue,
      required List<Word> wordList}) async {
    if (wordList.isEmpty) {
      wordList.add(Word.empty());
    }
    final docUser = FirebaseFirestore.instance.collection('list').doc(name);
    final listWords = ListOfWord(
      name: name,
      language: langue,
      words: wordList,
    );
    final json = listWords.toJson();

    await docUser.set(json);
  }
}
