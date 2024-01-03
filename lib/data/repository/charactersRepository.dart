import 'package:bloc_learning/data/models/character.dart';
import 'package:bloc_learning/data/models/quote.dart';
import 'package:bloc_learning/data/webServices/characterWebServices.dart';

class CharactersRepository{
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);

  Future<List<Character>> getAllCharacter() async{
    final character = await charactersWebServices.getAllCharacters();
    return character.map((character) => Character.fromJson(character)).toList();
  }

  Future<List<Quote>> getAllQuotes() async{
    final quote = await charactersWebServices.getAllQuotes();
    return quote.map((quote) => Quote.fromJson(quote)).toList();
  }
}