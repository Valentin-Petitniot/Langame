import 'Word.dart';

class ListOfWord
{
  String name;
  String language;
  List<Word>? words;
  ListOfWord({required this.name, required this.language, this.words});

  Map<String, dynamic> toJson () => {
    'listName': name,
    'listLang': language,
    'words' : words?.map((item) {
      return item.toJson();
    }).toList(),
  };

  factory ListOfWord.fromJson(Map<String, dynamic> json){
    if(json['words'] != null) {
      var wordObj = json['words'] as List;
      List<Word> wordS = wordObj.map((wordJson) => Word.fromJson(wordJson)).toList();
      return ListOfWord(
        name: json['listName'],
        language: json['listLang'],
        words: wordS
      );
    } else {
      return ListOfWord(
        name: json['listName'],
        language: json['listLang'],
      );
    }
  }
}