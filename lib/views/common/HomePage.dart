import 'package:flutter/material.dart';
import 'package:mvvmproject/views/auth/LoginScreen.dart';
import 'package:mvvmproject/views/employee/AddEmployee.dart';
import 'package:mvvmproject/views/employee/ViewEmployee.dart';
import 'package:mvvmproject/views/product/AddProduct.dart';
import 'package:mvvmproject/views/product/ViewAnimal.dart';
import 'package:mvvmproject/views/product/ViewProducts.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage > createState() => _HomePageState();
}

class _HomePageState extends State<HomePage > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.account_circle_outlined,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),

        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Home Page"),
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
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
                                  MaterialPageRoute(builder: (context)=> LoginScreen())
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
                  icon: Icon(Icons.logout)),
            ),
          ],
        ),
      ),

      drawer: Drawer(
      backgroundColor: Colors.cyan.shade50,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Column(
              children: [

            SizedBox(
              height: 50,
            ),
          Container(
            height: 60,
            width: 130,
            child: GestureDetector(
              onTap: () {
                // setState(() {
                // });
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>AddProduct()));
              },
              child: Container(
                color: Colors.yellow,
                padding: const EdgeInsets.all(8),
                child: Center(
                    child: Text(
                      " Add Products ",
                      style: TextStyle(color: Colors.black),
                    )),
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
                Container(
                  height: 60,
                  width: 130,
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      // });
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>ViewProducts()));
                    },
                    child: Container(
                      color: Colors.purple,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Text(
                            " View Products ",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                  height: 60,
                  width: 130,
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      // });
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>ViewAnimal()));
                    },
                    child: Container(
                      color: Colors.pink,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Text(
                            " Animal Listing ",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 70,
                ),
                Container(
                  height: 60,
                  width: 130,
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      // });
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>AddEmployee()));
                    },
                    child: Container(
                      color: Colors.lightBlue,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Text(
                            " Add Employee ",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),

                SizedBox(
                  height: 70,
                ),
                Container(
                  height: 60,
                  width: 130,
                  child: GestureDetector(
                    onTap: () {
                      // setState(() {
                      // });
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>ViewEmployee()));
                    },
                    child: Container(
                      color: Colors.greenAccent,
                      padding: const EdgeInsets.all(8),
                      child: Center(
                          child: Text(
                            " View Employee ",
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    ),
      body: Center(child: Padding(
        padding: const EdgeInsets.only(left: 29.0,top: 200),
        child: Column(
          children: [
            Text("MVVM Using API",style: TextStyle(fontSize: 20),),
            SizedBox(height: 15,),
            Text("Modules",style: TextStyle(fontSize: 20),),
            SizedBox(height: 15,),
            Text("Providers",style: TextStyle(fontSize: 20),)
          ],
        ),
      )),
    );
  }
}
