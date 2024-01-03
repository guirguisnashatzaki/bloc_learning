import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bloc_learning/business_logic/cubit/character_cubit.dart';
import 'package:bloc_learning/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/character.dart';

class Character_Details_Screen extends StatelessWidget {
  final Character character;

  Character_Details_Screen({Key? key, required this.character})
      : super(key: key);

  Widget checkIfQuotesAreLoaded(CharacterState state) {
    if (state is QuotesLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget showProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.yellow,
      ),
    );
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;

    if (quotes.length != 0) {
      int randomQuoteIndex = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: MyColors.white, shadows: [
            Shadow(blurRadius: 7, color: MyColors.yellow, offset: Offset(0, 0)),
          ]),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteIndex].quote)
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.grey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.title.toString(),
          style: TextStyle(color: MyColors.white),
        ),
        background: Hero(
          tag: character.id.toString(),
          child: Image.network(
            character.thumbnailUrl.toString(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharacterCubit>(context).getAllQuotes();

    return Scaffold(
      backgroundColor: MyColors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CharacterInfo(
                    character: character,
                    title: 'Job : ',
                  ),
                  BuildDivider(endEndent: 335),
                  CharacterInfo(
                    character: character,
                    title: 'Job : ',
                  ),
                  BuildDivider(endEndent: 335),
                  CharacterInfo(
                    character: character,
                    title: 'Job : ',
                  ),
                  BuildDivider(endEndent: 335),
                  CharacterInfo(
                    character: character,
                    title: 'Job : ',
                  ),
                  BuildDivider(endEndent: 335),
                  BlocBuilder<CharacterCubit, CharacterState>(
                      builder: (context, state) {
                    return checkIfQuotesAreLoaded(state);
                  })
                ],
              ),
            ),
                SizedBox(height: 300,)
          ]))
        ],
      ),
    );
  }
}

class BuildDivider extends StatelessWidget {
  BuildDivider({super.key, required this.endEndent});

  final double endEndent;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 30,
      color: MyColors.yellow,
      endIndent: endEndent,
      thickness: 2,
    );
  }
}

class CharacterInfo extends StatelessWidget {
  const CharacterInfo(
      {super.key, required this.character, required this.title});

  final Character character;
  final String title;

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
            text: title,
            style: TextStyle(
                color: MyColors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        TextSpan(
            text: character.title,
            style: TextStyle(color: MyColors.white, fontSize: 16))
      ]),
    );
  }
}
