import 'dart:ffi';

import 'package:bloc_learning/business_logic/cubit/character_cubit.dart';
import 'package:bloc_learning/constants/strings.dart';
import 'package:bloc_learning/data/repository/charactersRepository.dart';
import 'package:bloc_learning/presentation/screens/character_screen.dart';
import 'package:bloc_learning/presentation/screens/characters_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/models/character.dart';
import 'data/webServices/characterWebServices.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharacterCubit characterCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    characterCubit = CharacterCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allCharactersRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharacterCubit(charactersRepository),
                  child: const Character_Screen(),
                ));
      case charactersDetails:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (BuildContext context) => CharacterCubit(charactersRepository),
              child: Character_Details_Screen(
                    character: character,
                  ),
            ));
    }
  }
}
