import 'package:bloc/bloc.dart';
import 'package:bloc_learning/data/models/quote.dart';
import 'package:meta/meta.dart';

import '../../data/models/character.dart';
import '../../data/repository/charactersRepository.dart';

part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {

  final CharactersRepository characterRepository;
  List<Character> characters = [];
  List<Quote> quotes = [];

  CharacterCubit(this.characterRepository) : super(CharacterInitial());

  List<Character> getAllCharacters(){
    characterRepository.getAllCharacter().then((value){
      var newList = value.sublist(0,100);

      emit(CharacterLoaded(newList));
      this.characters = newList;
    });

    return characters;
  }

  List<Quote> getAllQuotes(){
    characterRepository.getAllQuotes().then((quotes){
      List<Quote> newListQuote = quotes.sublist(0,100);

      emit(QuotesLoaded(newListQuote));
      this.quotes = newListQuote;
    });

    return quotes;
  }
}
