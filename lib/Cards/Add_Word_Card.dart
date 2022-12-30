import 'package:flutter/material.dart';


class AddWordCard extends StatefulWidget {
  const AddWordCard({Key? key}) : super(key: key);

  @override
  State<AddWordCard> createState() => _AddWordCardState();
}

class _AddWordCardState extends State<AddWordCard> {


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
          ],
        ),
      ),
    );
  }
}
