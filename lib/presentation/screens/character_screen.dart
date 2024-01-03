import 'package:bloc_learning/business_logic/cubit/character_cubit.dart';
import 'package:bloc_learning/constants/colors.dart';
import 'package:bloc_learning/presentation/widgets/character_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../data/models/character.dart';

class Character_Screen extends StatefulWidget {
  const Character_Screen({Key? key}) : super(key: key);

  @override
  State<Character_Screen> createState() => _Character_ScreenState();
}

class _Character_ScreenState extends State<Character_Screen> {
  late List<Character> characters;
  late List<Character> searchedCharacters;
  bool isSearch = false;
  final searchTextController = TextEditingController();

  Widget _buildSearchField() {
    return TextField(
      controller: searchTextController,
      cursorColor: MyColors.yellow,
      decoration: InputDecoration(
        hintText: 'Find a character',
        hintStyle: TextStyle(color: MyColors.grey, fontSize: 18),
      ),
      style: TextStyle(color: MyColors.grey, fontSize: 18),
      onChanged: (value) {
        setState(() {
          searchedCharacters = characters
              .where(
                  (element) => element.title!.toLowerCase().startsWith(value))
              .toList();
        });
      },
    );
  }

  List<Widget> _buildAppBarActions() {
    if (isSearch) {
      return [
        IconButton(
            onPressed: () {
              setState(() {
                searchTextController.clear();
              });
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: MyColors.grey,
            ))
      ];
    } else {
      return [IconButton(onPressed: () {
        _startSearch();
      }, icon: Icon(Icons.search,color: MyColors.grey,))];
    }
  }

  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));
    setState(() {
      isSearch = true;
    });
  }

  void _stopSearch(){
    setState(() {
      searchTextController.clear();
      isSearch = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    characters = BlocProvider.of<CharacterCubit>(context).getAllCharacters();
  }

  Widget buildLoadedList() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.grey,
        child: Column(
          children: [
            GridView.builder(
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: searchTextController.text.toString().isEmpty ? characters.length : searchedCharacters.length,
                itemBuilder: (context, index) {
                  return CharacterListItem(
                    character: searchTextController.text.isEmpty ? characters[index]:searchedCharacters[index],
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget builBlocWidget() {
    return BlocBuilder<CharacterCubit, CharacterState>(
        builder: (context, state) {
      if (state is CharacterLoaded) {
        characters = (state).characters;
        return buildLoadedList();
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.yellow,
        leading: isSearch ? BackButton(color: MyColors.grey,):Container(),
        title:isSearch ? _buildSearchField() : const Text(
          "Characters",
          style: TextStyle(color: MyColors.grey),
        ),
        actions: _buildAppBarActions(),
      ),
      body:OfflineBuilder(
        connectivityBuilder: (BuildContext context,ConnectivityResult connectivity,Widget child){
          final bool connected = connectivity != ConnectivityResult.none;

          if(connected){
            return builBlocWidget();
          }else{
            return  Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Can\'t connect .. check internet',
                      style: TextStyle(
                        fontSize: 22,
                        color: MyColors.grey,
                      ),
                    ),
                    Image.asset('assets/images/no_internet.png')
                  ],
                ),
              ),
            );
          }
        },
        child: Center(
          child: CircularProgressIndicator(
            color: MyColors.yellow,
          ),
        ),
      )

      //builBlocWidget(),
    );
  }
}
