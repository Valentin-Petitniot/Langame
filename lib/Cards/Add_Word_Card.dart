import 'package:flutter/material.dart';

const List<String> lgList = <String>['En', 'Fr', 'Nl', 'De'];

class AddWordCard extends StatefulWidget {
  const AddWordCard({Key? key}) : super(key: key);

  @override
  State<AddWordCard> createState() => _AddWordCardState();
}

class _AddWordCardState extends State<AddWordCard> {
  String dropDownValue = lgList.first;

  @override
  Widget build(BuildContext context) {
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
              children: const [
                Padding(
                  padding:  EdgeInsets.fromLTRB(15, 10, 0, 0),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Mot Français',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 15),
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Traduction',
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(60, 50, 0, 0),
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
          ],
        ),
      ),
    );
  }
}
