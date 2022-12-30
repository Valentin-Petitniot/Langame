import 'package:flutter/material.dart';

import 'package:langame/Button/Add_Word_Button.dart';
import 'package:langame/Cards/Add_Word_Card.dart';
import 'package:langame/Class/List_of_Words.dart';

class EditListScreen extends StatefulWidget {
   EditListScreen({Key? key, required this.test}) : super(key: key);

  final ListOfWord test;

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

final List<Widget> wordList = [];

void addWordList() {
  wordList.add(
     const AddWordCard(),
  );
}

class _EditListScreenState extends State<EditListScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
              ),
              Icon(Icons.list),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Text('Modifier la Liste'),
              Padding(
                padding: const EdgeInsets.only(left: 85),
                child: AddWordButton(
                  onPressed: () {
                    widget.test.nbrelem++;
                    setState(
                      () {
                        addWordList();
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

                      autocorrect: true,
                      initialValue: 'Nom de la Liste',
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.test.nbrelem+1,
                  itemBuilder: (context, index) {
                    return AddWordCard();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
