import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvmproject/views/auth/LoginScreen.dart';
import 'package:mvvmproject/views/common/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/MyButton.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  //
  // var txtname="";
  // var txtpassword="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Text("Registration"),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: IconButton(
                    onPressed: () {
                      AlertDialog alert = new AlertDialog(
                        title: Center(child: Text("ALert !")),
                        content: Text("You Want To Logout !"),
                        actions: [
                          Row(
                            children: [
                              TextButton(onPressed: (){  Navigator.of(context).pop();}, child: Text("Cancel")),
                              TextButton(onPressed: (){
                                Navigator.of(context).pop();
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=> RegisterScreen())
                                );
                              }, child: Text("LogOut")),
                            ],
                          )
                        ],
                      );
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          });
                    },
                    icon: Icon(Icons.access_time)),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 130,
            ),
            Padding(
              padding:  EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                cursorColor: Colors.black54,
                style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.purple.shade900),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    labelStyle: TextStyle(fontSize: 18,color: Colors.grey.shade700),
                    hintText: 'Enter secure password',
                    hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.black45)
                ),
                obscureText: true,
                controller: _name,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding:  EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                cursorColor: Colors.black54,
                style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2,color: Colors.purple.shade900),
                      borderRadius: BorderRadius.circular(60),
                    ),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    labelStyle: TextStyle(fontSize: 18,color: Colors.grey.shade700),
                    hintText: 'Enter secure password',
                    hintStyle: TextStyle(fontStyle: FontStyle.italic,color: Colors.black45)
                ),
                obscureText: true,
                controller: _password,
              ),
            ),
            SizedBox(
              height: 100,
            ),
            MyButton(
              onclick: () async {
                   var nm = _name.text.toString();
                   var ps = _password.text.toString();
                   SharedPreferences prefs = await SharedPreferences.getInstance();

                   prefs.setString("name", nm);
                   prefs.setString("password", ps);
                   Fluttertoast.showToast(msg: "Registered");
                   Navigator.of(context).pop();
                   Navigator.of(context).push(
                       MaterialPageRoute(builder: (context)=>LoginScreen()
                       )
                   );
                   // var mainname = prefs.getString("name");
                   // var mainpassword = prefs.getString("password");
                   //
                   // if(nm==mainname && ps==mainpassword)
                   // {
                   //   Fluttertoast.showToast(msg: "Entered Successfully");
                   //   SharedPreferences prefs = await SharedPreferences.getInstance();
                   //   prefs.setString("Name", nm);
                   //   prefs.setString("islogin","yes");
                   //   Navigator.of(context).pop();
                   //   Navigator.of(context).push(
                   //       MaterialPageRoute(builder: (context)=>HomePage())
                   //   );
                   // }
                   // else
                   // {
                   //   Fluttertoast.showToast(msg: "Error");
                   // }

              },
              btntext: "Register",
            ),
            // GestureDetector(
            //   onTap: (){
            //     Navigator.of(context).pop();
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context)=>LoginScreen())
            //     );
            //   },
            //   child: Container(
            //     margin: EdgeInsets.all(10.0),
            //     color: StyleResources.btncolor,
            //     width: MediaQuery.of(context).size.width,
            //     height: 60.0,
            //     alignment: Alignment.center,
            //     child: Text("Register",style: StyleResources.btntext,),
            //   ),
            // ),
            SizedBox(
              height: 200.0,
            ),
            // Center(
            //   child: Column(
            //     children: [
            //
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
