import 'package:flutter/material.dart';

import 'package:langame/Button/Add_Word_Button.dart';
import 'package:langame/Cards/Add_Word_Card.dart';
import 'package:langame/Class/List_of_Words.dart';

const List<String> lgList = <String>['En', 'Fr', 'Nl', 'De'];

class EditListScreen extends StatefulWidget {
   const EditListScreen({Key? key}) : super(key: key);

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

final List<Widget> wordList = [];
int num = 0;


class _EditListScreenState extends State<EditListScreen> {

  TextEditingController nameCtrl = TextEditingController();
  late String languageCtrl;

  void addWordList() {
    wordList.add(
      const AddWordCard(),
    );
  }

  String dropDownValue = lgList.first;
  
  onPressed(BuildContext context){
    var data = ListOfWord(name: nameCtrl.text, language: languageCtrl);
    Navigator.pop(context, data);
  }

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
                    num++;
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
                        switch(value)
                        {
                          case 'En': languageCtrl = 'Anglais';
                          break;
                          case 'Fr': languageCtrl = 'Français';
                          break;
                          case 'Nl': languageCtrl = 'Néerlandais';
                          break;
                          case 'De': languageCtrl = 'Allemand';
                          break;
                        }
                      },
                    );
                  },
                  dropdownColor: Colors.black,
                  items: lgList.map<DropdownMenuItem<String>>((String value){
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

                      autocorrect: true,
                      initialValue: 'Nom de la Liste',
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        var newValue = value ?? "";
                        if(newValue.isEmpty) {
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
                    return AddWordCard();
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            if(Form.of(context)?.validate() ?? false){
              onPressed(context);
            }
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
