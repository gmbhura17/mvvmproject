import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvmproject/views/sportson/TeamHomePage.dart';
import 'package:uuid/uuid.dart';

class TeamLoginPage extends StatefulWidget {

  @override
  State<TeamLoginPage> createState() => _TeamLoginPageState();
}

class _TeamLoginPageState extends State<TeamLoginPage> {
  File sportsfile;
  ImagePicker _sportspicker = ImagePicker();
  TextEditingController _tn = TextEditingController();
  TextEditingController _pl = TextEditingController();
  TextEditingController _ye = TextEditingController();
  TextEditingController _de = TextEditingController();
  bool isloading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Login Page"),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.greenAccent,
          child: Column(
            children: [
              SizedBox(height: 40,),
              (sportsfile!=null)?Image.file(sportsfile,width: 130,):Image.asset("img/sportslogo.jpg",width: 130,),
              SizedBox(height: 40,),
              Text("Sports-On",style: TextStyle(fontSize: 30),),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async
                    {
                      XFile photo = await _sportspicker.pickImage(source: ImageSource.camera);
                      setState((){
                        sportsfile = File(photo.path);
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Camera",style: TextStyle(fontSize: 15,),)),
                        )),
                  ),
                  GestureDetector(
                    onTap: () async
                    {
                      XFile photo = await _sportspicker.pickImage(source: ImageSource.gallery);
                      setState((){

                        sportsfile= File(photo.path);
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black,width: 2)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(child: Text("Gallary",style: TextStyle(fontSize: 15, ),)),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Text("Squad Name :"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _tn,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Player Name :"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _pl,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Description :"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _ye,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Text("Year :"),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    controller: _de,
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                  onTap: () async{
                    setState((){
                      isloading=true;
                    });
                    var uuid = Uuid();
                    var filename = uuid.v1();
                    await FirebaseStorage.instance.ref(filename).putFile(sportsfile).whenComplete((){}).then((filedata) async{
                      await filedata.ref.getDownloadURL().then((fileurl) async{
                        var name = _tn.text.toString();
                        var player = _pl.text.toString();
                        var dec = _de.text.toString();
                        var year = _ye.text.toString();
                        await FirebaseFirestore.instance.collection("Sportson").add ({
                          "squadname":name,
                          "playername":player,
                          "description":dec,
                          "year":year,
                          "sportsfile":filename,
                          "imageurl1":fileurl
                        }).then((value){
                          print("Record Inserted");
                          _tn.text="";
                          _pl.text="";
                          _de.text="";
                          _ye.text="";
                          setState((){
                            sportsfile=null;
                          });
                          setState((){
                            isloading=true;
                          });
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>TeamHomePage())
                          );
                        });

                      });
                    });
                  },


                  child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black,width: 2)
                      ),
                      child: Center(child: Text("Submit",style: TextStyle(fontSize: 25,  ),)))),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
