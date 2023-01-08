class Word {
  late String original;
  late String translate;

  Word(this.original, this.translate); // Initialize Constructor

  Word.empty() {
    original = '';
    translate = '';
  }

  Map<String, dynamic> toJson() => {
    'original' : original,
    'traduit' : translate,
  };

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(json['original'], json['traduit']);
  }
}
