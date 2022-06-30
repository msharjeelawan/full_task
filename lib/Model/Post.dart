
//model class for post
class Post{

  int _id=0;
  String _title="";
  String _description="";

  Post(this._id,this._title,this._description);

  static List<Post> jsonToModel(List<dynamic> postList){
    var list=<Post>[];
    postList.forEach((postMap) {
      list.add(Post(postMap["id"],postMap["title"],postMap["body"]));
    });
    return list;
  }

  String get description => _description;

  String get title => _title;

  int get id => _id;

}