import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_task/Controller/home_provider.dart';
import 'package:test_task/Helpers/Constant.dart';

import '../Model/Post.dart';

class HomeScreen extends StatelessWidget {
  //provider for maintaining state
  final _provider=HomeProvider();
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.cyan,
          statusBarIconBrightness: Brightness.light
        ),
        actions: [
          IconButton(
              onPressed: () async{
                (await SharedPreferences.getInstance()).remove("isLogin");
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              },
              icon: Icon(Icons.logout,color: Constant.white,)
          )
        ],
      ),
      body: FutureBuilder(
          future: _provider.getPosts(),
          builder: (context,snapshot){
            //builder is call two time, when request is send and after response received

            if(!snapshot.hasData && snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }

            if(snapshot.connectionState==ConnectionState.done && !snapshot.hasData){
              return const Center(child: Text("No Post Found"),);
            }

            //cast into its type for usage in listview builder
            List<Post> list=snapshot.data as List<Post>;

            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.black12),borderRadius: BorderRadius.circular(5)),
                      title: Text("id: ${list[index].id}",overflow: TextOverflow.fade,),
                      subtitle: Text("Title: "+list[index].title,overflow: TextOverflow.fade,),
                    ),
                  );
                }
            );
          }
      ),
    );
  }
}
