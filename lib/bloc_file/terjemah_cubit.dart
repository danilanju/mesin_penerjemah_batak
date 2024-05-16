import 'package:flutter_bloc/flutter_bloc.dart';
//import '../koneksi.dart';
import 'logic.dart';

//class cubit terjemahkan
class TranslationState {
  final String translatedText;

  TranslationState({required this.translatedText});
}

class TranslationCubit extends Cubit<TranslationState> {
  TranslationCubit() : super(TranslationState(translatedText: ""));

  void translateText(String inputText) async {
    List<Token> tokens = tokenizeText(inputText);
    List<String> translatedTokens = [];

    for (Token token in tokens) {
      await translateToken(token, translatedTokens);
    }

    String joinedTranslation = translatedTokens.join(' ');
    joinedTranslation = joinedTranslation.replaceAll(RegExp(r'\s+'), ' ');

    emit(TranslationState(translatedText: joinedTranslation));
  }
}
