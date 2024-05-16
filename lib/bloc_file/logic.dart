import '../koneksi.dart';

class Token {
  final String value;
  final bool isWord;

  Token({required this.value, required this.isWord});
}

List<Token> tokenizeText(String text) {
  text = text.toLowerCase();
  List<Token> tokens = [];

  RegExp regExp = RegExp(r"(\w+|\W)");

  for (RegExpMatch match in regExp.allMatches(text)) {
    String value = match.group(0)!;
    bool isWord = RegExp(r"\w").hasMatch(value);
    tokens.add(Token(value: value, isWord: isWord));
  }

  return tokens;
}

Future<void> translateToken(Token token, List<String> translatedTokens) async {
  if (token.isWord) {
    try {
      PostKata result = await PostKata.connectKeAPI(token.value);
      String translatedToken =
          result.arti.isNotEmpty ? result.arti : token.value;
      translatedTokens.add(translatedToken);
    } catch (e) {
      print("Error translating token '${token.value}': $e");
      translatedTokens.add(token.value);
    }
  } else {
    translatedTokens.add(token.value);
  }
}

void translateText(String inputText, Function(PostKata) callback) async {
  List<Token> tokens = tokenizeText(inputText);
  List<String> translatedTokens = [];

  for (Token token in tokens) {
    await translateToken(token, translatedTokens);
  }

  String joinedTranslation = translatedTokens.join(' ');
  joinedTranslation = joinedTranslation.replaceAll(RegExp(r'\s+'), ' ');

  callback(PostKata(arti: joinedTranslation));
}
