part of 'character_cubit.dart';

@immutable
abstract class CharacterState {}

class CharacterInitial extends CharacterState {}

class CharacterLoaded extends CharacterState{
  final List<Character> characters;

  CharacterLoaded(this.characters);
}

class QuotesLoaded extends CharacterState{
  final List<Quote> quotes;

  QuotesLoaded(this.quotes);
}
