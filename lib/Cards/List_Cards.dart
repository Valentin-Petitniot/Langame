import 'package:flutter/material.dart';
import 'package:langame/Class/List_of_Words.dart';

import 'package:langame/Routes/routes.dart';
import 'package:langame/Screens/list_screen.dart';
import 'package:langame/Button/Modif_List_Button.dart';
import '../Class/Word.dart';
import '../Routes/router.dart';
import '../Screens/Edit_List_Screen.dart';

class ListCards extends StatefulWidget {

  final ListOfWord test;

  const ListCards({Key? key, required this.test}) : super(key: key);

  @override
  State<ListCards> createState() => _ListCardsState();
}

class _ListCardsState extends State<ListCards> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, kViewWordList);
        },
        child: Container(
          height: MediaQuery.of(context).size.width / 4,
          decoration: const BoxDecoration(
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                    child: Text(
                      widget.test.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: 160,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 2, 35),
                        child: ModifListButton(
                          onPressed: () {
                            Word Testword = Word(original: 'oui', translate: 'yes');
                            widget.test.wordList.add(Testword);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditListScreen(test: widget.test),
                              ),
                            );
                          }
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                        child: Text(
                          'Anglais',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
