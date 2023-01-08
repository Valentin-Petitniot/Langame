import 'package:flutter/material.dart';

import '../Model/List_of_Words.dart';
import '../Model/Word.dart';
import '../Partials/Cards/List_Cards.dart';
import '../Partials/Cards/Input_Word.dart';

class ViewWordsListScreen extends StatefulWidget {
  const ViewWordsListScreen({Key? key, required this.listOfWord})
      : super(key: key);

  final ListOfWord listOfWord;

  @override
  State<ViewWordsListScreen> createState() => _ViewWordsListScreenState();
}

int num = 0;

class _ViewWordsListScreenState extends State<ViewWordsListScreen> {
  late List<Word> _wordList = [];

  @override
  void initState() {
    _wordList = widget.listOfWord.words!;
    num = _wordList.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        shadowColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Row(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),
            ),
            Text(
              'Liste: ${widget.listOfWord.name}',
              style: TextStyle(
                color: Colors.lightBlue,
              ),
            ),
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
            )
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            ListCards(
                name: widget.listOfWord.name,
                language: widget.listOfWord.language),
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
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                            child: SizedBox(
                              height: 50,
                              child: WordInput(
                                hintText: 'Mot Original',
                                label: _wordList[index].original,
                                onChanged: (value) {
                                  _wordList[index].original = value;
                                  print('original: ' +
                                      _wordList[index].original);
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
                                label: _wordList[index].translate,
                                onChanged: (value) {
                                  _wordList[index].translate = value;
                                  print('traduit: ' +
                                      _wordList[index].translate);
                                },
                              ),
                            ),
                          ),
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
    );
  }
}
