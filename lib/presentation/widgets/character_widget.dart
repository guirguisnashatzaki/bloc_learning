import 'package:bloc_learning/constants/colors.dart';
import 'package:bloc_learning/constants/strings.dart';
import 'package:bloc_learning/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterListItem extends StatelessWidget {
  final Character character;

  CharacterListItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: MyColors.white, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, charactersDetails,arguments: character);
        },
        child: GridTile(
          child: Hero(
            tag: character.id.toString(),
            child: Container(
              color: MyColors.grey,
              child: character.thumbnailUrl!.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      placeholder: "assets/images/loading.gif",
                      image: character.thumbnailUrl.toString(),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Image.asset("assets/images/no_internat.png"),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              character.title!,
              style: TextStyle(
                  height: 1.3,
                  fontSize: 16,
                  color: MyColors.white,
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
