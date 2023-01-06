import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:langame/Button/Add_Word_Button.dart';
import 'package:langame/Cards/List_Cards.dart';
import 'package:langame/Class/List_of_Words.dart';

import '../Class/Word.dart';
import '../Partials/Input_Word.dart';

const List<String> lgList = <String>['Langue', 'En', 'Fr', 'Nl', 'De'];

class EditListScreen extends StatefulWidget {
  const EditListScreen(
      {Key? key, required this.nameList, required this.langList})
      : super(key: key);

  final String nameList;
  final String langList;

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

final List<Widget> widgetWordList = [];
int num = 0;

String initialValueDropDown(String rcvLang) {
  String result = 'Langue';

  switch (rcvLang) {
    case 'Anglais':
      result = 'En';
      break;
    case 'Français':
      result = 'Fr';
      break;
    case 'Allemand':
      result = 'De';
      break;
    case 'Néerlandais':
      result = 'Nl';
      break;
  }

  return result;
}

class _EditListScreenState extends State<EditListScreen> {
  TextEditingController nameCtrl = TextEditingController();
  late String languageCtrl;
  final List<Word> _wordsList = [];

  String dropDownValue = lgList.first;

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
              ListCards(name: widget.nameList, language: widget.langList),
              Expanded(
                child: ListView.builder(
                  itemCount: num,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(10),
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
                                      onChanged: (value){
                                        _wordsList[index].original = value;
                                        print('original: ' + _wordsList[index].original);
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
                                      onChanged: (value){
                                        _wordsList[index].translate = value;
                                        print('traduit: ' + _wordsList[index].translate);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
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
            widgetWordList.clear();
            ListOfWord result =
                ListOfWord(name: widget.nameList, language: widget.langList);
            Navigator.pop(context, result);

          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
