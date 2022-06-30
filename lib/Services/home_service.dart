import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Model/Post.dart';

class HomeService{

  final String _apiHost="https://jsonplaceholder.typicode.com/";
  
  Future<List<Post>> sendRequestForPosts() async{
    return await http.get(Uri.parse(_apiHost+"Posts")).then((response) {
      if(response.body.isEmpty) {
        return [];
      }

      if(response.statusCode==200){
        try{
          List<dynamic> list = jsonDecode(response.body);
          var postList = Post.jsonToModel(list);
          return postList;
        }catch(e){
          print(e.toString());
        }
      }

      return [];
    });

  }
}