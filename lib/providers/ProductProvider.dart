import 'package:flutter/material.dart';
import '../helpers/ApiHandler.dart';
import '../helpers/error_handler.dart';
import '../models/Product.dart';
import '../resources/UrlResources.dart';
import '../views/auth/LoginScreen.dart';

class ProductProvider with ChangeNotifier
{
  List<Product> alldata;

  allproducts(context) async
  {
    try
    {
      await ApiHandler.get(UrlResources.ALL_PRODUCTS).then((json) async {
        alldata = json["data"].map<Product>((obj)=>Product.fromJson(obj)).toList();
        notifyListeners();
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.message.toString()=="Internet Connection Failure")
      {
        // No Internet
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      else if(ex.message.toString()=="Bad Response Format")
      {

      }
      else
      {

      }
    }
  }

  bool isinserted=false;
  addproducts(context,params) async
  {
    try
    {
      await ApiHandler.post(UrlResources.ADD_PRODUCTS,body: params).then((json){
        if(json["status"]=="true")
        {
          isinserted = true;
        }
        else
        {
          isinserted = false;
        }
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.message.toString()=="Internet Connection Failure")
      {
        // No Internet
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      else if(ex.message.toString()=="Bad Response Format")
      {

      }
      else
      {

      }
    }
  }

  bool isdeleted=false;
  deleteproducts(context,params) async
  {
    try
    {
      await ApiHandler.post(UrlResources.DELETE_PRODUCTS,body: params).then((json){
        if(json["status"]=="true")
        {
          isdeleted = true;
        }
        else
        {
          isdeleted = false;
        }
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.message.toString()=="Internet Connection Failure")
      {
        // No Internet
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      else if(ex.message.toString()=="Bad Response Format")
      {

      }
      else
      {

      }
    }
  }

  Product singleobj;

  editproducts(context,params) async
  {
    try
    {
      await ApiHandler.post(UrlResources.SINGLE_PRODUCTS,body: params).then((json){
        singleobj = Product.fromJson(json["data"]);
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.message.toString()=="Internet Connection Failure")
      {
        // No Internet
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      else if(ex.message.toString()=="Bad Response Format")
      {

      }
      else
      {

      }
    }
  }


  bool isupdated=false;
  updateproduct(context,params) async
  {
    try
    {
      await ApiHandler.post(UrlResources.EDIT_PRODUCTS,body: params).then((json){
        if(json["status"]=="true")
        {
          isupdated = true;
        }
        else
        {
          isupdated = false;
        }
      });
    }
    on ErrorHandler catch (ex)
    {
      if(ex.message.toString()=="Internet Connection Failure")
      {
        // No Internet
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
      else if(ex.message.toString()=="Bad Response Format")
      {

      }
      else
      {

      }
    }
  }

}
