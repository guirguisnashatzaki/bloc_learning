import 'package:bloc_learning/constants/strings.dart';
import 'package:dio/dio.dart';

class CharactersWebServices{
  late Dio dio;

  CharactersWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 60),
      receiveTimeout: Duration(seconds: 60)
    );

    dio =Dio(options);

  }

  Future<List<dynamic>> getAllCharacters() async{
    try{
      Response response = await dio.get("photos");
      print(response.data.toString());
      return response.data;
    }catch(e){
      print(e.toString());
      return [];
    }

  }

  Future<List<dynamic>> getAllQuotes() async{
    try{
      Response response = await dio.get("todos");
      print(response.data.toString());
      return response.data;
    }catch(e){
      print(e.toString());
      return [];
    }

  }

}