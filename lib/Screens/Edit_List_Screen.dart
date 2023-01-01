import 'package:flutter/material.dart';

import 'package:langame/Button/Add_Word_Button.dart';
import 'package:langame/Cards/Add_Word_Card.dart';
import 'package:langame/Class/List_of_Words.dart';

const List<String> lgList = <String>['Langue' ,'En', 'Fr', 'Nl', 'De'];

class EditListScreen extends StatefulWidget {
   const EditListScreen({Key? key, required this.nameList, required this.langList}) : super(key: key);

   final String nameList;
   final String langList;

  @override
  State<EditListScreen> createState() => _EditListScreenState();
}

final List<Widget> wordList = [];
int num = 0;

String initialValueDropDown(String rcvLang){
  String result = 'Langue';

  switch(rcvLang)
  {
    case 'Anglais': result = 'En';
    break;
    case 'Français': result = 'Fr';
    break;
    case 'Allemand': result = 'De';
    break;
    case 'Néerlandais': result = 'Nl';
    break;
  }

  return result;
}

class _EditListScreenState extends State<EditListScreen> {

  TextEditingController nameCtrl = TextEditingController();
  late String languageCtrl;

  void addWordList() {
    wordList.add(
      const AddWordCard(),
    );
  }

  String dropDownValue = lgList.first;

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
                  value: initialValueDropDown(widget.langList),
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
                        print('changement de langue');
                        switch(dropDownValue)
                        {
                          case 'En': languageCtrl = 'Anglais';
                                      print('Anglais séléctionné');
                          break;
                          case 'Fr': languageCtrl = 'Français';
                                      print(languageCtrl + ' séléctionné');
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
                      //initialValue: widget.nameList,
                      controller: nameCtrl,
                      autocorrect: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
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
            /*if(Form.of(context)?.validate() ?? false){
              onPressed(context);
            }*/

            if(widget.langList != null)
              {
                languageCtrl = widget.langList;
              }
            print('Edit_List_Screen ' + nameCtrl.text + languageCtrl);
            ListOfWord result = ListOfWord(name: nameCtrl.text, language: languageCtrl);
            Navigator.pop(context, result);
            num = 0;
            wordList.clear();
          },
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
