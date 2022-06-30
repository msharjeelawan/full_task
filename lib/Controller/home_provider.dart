
import 'package:test_task/Services/home_service.dart';

import '../Model/Post.dart';

class HomeProvider{
  //initialize home service for provider
  final service=HomeService();
  Future<List<Post>> getPosts() async{
    return await service.sendRequestForPosts();
  }
}