import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mvvmproject/views/sportson/TeamLoginPage.dart';
import 'package:mvvmproject/views/sportson/TeamUpdatePage.dart';

class TeamHomePage extends StatefulWidget {

  @override
  State<TeamHomePage> createState() => _TeamHomePageState();
}

class _TeamHomePageState extends State<TeamHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Team Home Page"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TeamLoginPage()));
        },
        child: Text("Add"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Sportson").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.size <= 0) {
              return Center(
                child: Text("No data Found. .. "),
              );
            } else {
              return ListView(
                children: snapshot.data.docs.map((document) {
                  return Container(
                    width: 400,
                    height: 400,
                    child: Column(
                      children: [
                        Card(
                          elevation: 20,
                          color: Colors.yellowAccent,
                          child: Container(
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Column(

                                          children: [
                                            Image.network(
                                              document["imageurl1"],
                                              height: 140,
                                            ),

                                            SizedBox(height: 20,),
                                            Text(document["squadname"].toString(),style: TextStyle(fontSize: 20,color: Colors.red),),
                                            Text(document["playername"].toString(),style: TextStyle(fontSize: 20,color: Colors.red),),
                                            Text(document["description"].toString(),style: TextStyle(fontSize: 20,color: Colors.red),),
                                            Text(document["year"].toString(),style: TextStyle(fontSize: 20,color: Colors.red),),
                                            SizedBox(height: 20,)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //--------------------------------------------

                                Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 80.0,left: 100),
                                      child: GestureDetector(
                                        onTap: () async {
                                          var docid = document.id.toString();
                                          await FirebaseStorage.instance.ref(document["sportsfile"].toString()).delete().then((value) async{
                                            await FirebaseFirestore.instance.collection("Sportson").doc(docid).delete().then((value){
                                              print("Record Deleted");
                                            });
                                          });

                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: .0),
                                          child: Container(
                                              height: 40,
                                              color: Colors.white,
                                              width: 70,
                                              child: Center(
                                                  child: Text(
                                                    "  Delete ",
                                                    style: TextStyle(
                                                        color: Colors.black),
                                                  ))),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 100.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          var docid = document.id.toString();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(builder: (context)=>TeamUpdatePage(
                                                updatesonid: docid,
                                              ))
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(),
                                          child: Container(
                                              height: 40,
                                              color: Colors.black,
                                              width: 70,
                                              child: Center(
                                                  child: Text(
                                                    "  Update ",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                //  ----------------------------------------
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
