import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvmproject/models/Animal.dart';
import 'package:mvvmproject/views/product/ViewProducts.dart';
import '../helpers/ApiHandler.dart';
import '../helpers/error_handler.dart';
import '../resources/UrlResources.dart';
import '../views/auth/LoginScreen.dart';
class AnimalProvider with ChangeNotifier
{
  List<Animal> alldata;
  allanimals(context) async
  {
    try
    {
      await ApiHandler.get(UrlResources.ANIMAL).then((json) async {
        alldata = json.map<Animal>((obj)=>Animal.fromJson(obj)).toList();
        notifyListeners();
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.message.toString()=="Internet Connection Failure")
      {
        // No Internet
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      else if(ex.message.toString()=="Bad Response Format")
      {
        print(Text("Error"));
      }
      else
      {

      }
    }
  }
  addproducts() async
  {

  }

  deleteproducts() async
  {

  }

}