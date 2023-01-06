class Word {
  late String original;
  late String translate;

  Word(this.original, this.translate); // Initialize Constructor

  Word.empty() {
    original = "";
    translate = "";
  }

  Map<String, dynamic> toJson() => {
    'original' : original,
    'traduit' : translate,
  };

  factory Word.fromJson(dynamic json) {
    return Word(json['original'] as String, json['traduit'] as String);
  }
}
