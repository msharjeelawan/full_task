import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../Controller/login_provider.dart';
import '../Helpers/Constant.dart';

class LoginScreen extends StatelessWidget {
  //provider for maintaining state
  final _provider=LoginProvider();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = Constant.getWidth(context);
    double height = Constant.getHeight(context);
    return ChangeNotifierProvider<LoginProvider>(
      create: (BuildContext context) {
        return _provider;
      },
      builder: (context,child){
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Constant.white,
                statusBarIconBrightness: Brightness.light
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: height-30,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Constant.white,
                        Constant.primaryColor
                      ]
                  )
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        width: width*0.5,
                        child: Column(
                          mainAxisAlignment:  MainAxisAlignment.end,
                          children: [
                            Text("Hello Again!",style:TextStyle(fontSize: 28,color: Constant.black,fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5,),
                            Text("Chance to get your life better",textAlign: TextAlign.center,style:TextStyle(fontSize: 18,color: Constant.black)),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      flex: 2,
                      child: Form(
                        key: _provider.formState,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onSaved: (newValue) => _provider.email = newValue.toString().trim(),
                              validator: (email){
                                if(!email!.contains(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))){
                                  return "Please enter correct email";
                                }
                              },
                              decoration: InputDecoration(
                                  fillColor: Constant.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                  // labelText: "Email",
                                  hintText: "Enter your email here",
                                  prefixIcon: const Icon(Icons.email_outlined),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Constant.white)
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(color: Constant.white)
                                  )
                              ),
                            ),
                            Consumer<LoginProvider>(
                              builder: (BuildContext context,state,Widget? child){
                                return TextFormField(
                                  obscureText:state.isObscure,
                                  onSaved: (newValue) => _provider.password = newValue.toString().trim(),
                                  validator: (password){
                                    if(password!.length<6){
                                      return "Password length must greater then 6";
                                    }
                                  },
                                  decoration: InputDecoration(
                                      fillColor: Constant.white,
                                      filled: true,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                                      // labelText: "Password",
                                      hintText: "Enter your password...",
                                      prefixIcon: const Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(onPressed: (){
                                        print(state.isObscure);
                                        Provider.of<LoginProvider>(context,listen: false).showHidePassword();
                                      }, icon: Icon(state.isObscure? Icons.visibility : Icons.visibility_off)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(color: Constant.primaryColor)
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          borderSide: BorderSide(color: Constant.primaryColor)
                                      )),
                                );
                              },
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(context, '/forgot');
                                  },
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Constant.black),
                                  )
                              ),
                            ),
                            const SizedBox(),
                            TextButton(
                                onPressed: (){
                                  _provider.signIn(context:context);
                                },
                                style: ButtonStyle(
                                    backgroundColor:MaterialStateProperty.all(Constant.greenColor),
                                    fixedSize: MaterialStateProperty.all(Size(width, height*0.07)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Constant.white),
                                )
                            ),
                            // const SizedBox(height: 5,),
                          ],
                        ),
                      )
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text("or continue with",style: TextStyle(fontSize: 13)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Constant.white,width: 2),
                                  color: Constant.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(onPressed: (){},
                                    iconSize: 20,
                                    icon: Image.asset("assets/icons/google_icon.png",)
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Constant.white,width: 2),
                                  color: Constant.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(onPressed: (){},
                                    iconSize: 20,
                                    icon: Image.asset("assets/icons/apple_icon.png",)
                                ),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                // padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Constant.white,width: 2),
                                  color: Constant.primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: IconButton(onPressed: (){},
                                    iconSize: 20,
                                    icon: Image.asset("assets/icons/facebook_icon.png",)
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Not a member?"),
                              TextButton(
                                  onPressed: (){},
                                  child: Text("Register now",style: TextStyle(color: Constant.greenColor),)
                              )
                            ],
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}


