import 'dart:convert';

class Word {
  String _original;
  String _translate;

  Word(this._original, this._translate); // Initialize Constructor

  Word.fromJson(Map<String, dynamic> json)
      : _original = json['original'],
        _translate = json['traduit'];

  Map<String, dynamic> toJson() => {
    'original': _original,
    'traduit': _translate,
  };

}
