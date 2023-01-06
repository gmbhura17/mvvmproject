import 'package:flutter/material.dart';
import 'package:mvvmproject/models/Employee.dart';
import '../helpers/ApiHandler.dart';
import '../helpers/error_handler.dart';
import '../resources/UrlResources.dart';
import '../views/auth/LoginScreen.dart';

class EmployeeProvider with ChangeNotifier
{
  List<Employee> alldata;
  allemployees(context) async
  {
    try
    {
      await ApiHandler.get(UrlResources.ALL_EMPLOYEE).then((json) async {
        alldata = json["data"].map<Employee>((obj)=>Employee.fromJson(obj)).toList();
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
        print("Error");
      }
    }
  }

  bool isinserted=false;
  addemployee(context,params) async
  {
    try
    {
      await ApiHandler.post(UrlResources.ADD_EMPLOYEE,body: params).then((json){
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
  deleteemployee(context,params) async
  {
    try
    {
      await ApiHandler.post(UrlResources.DELETE_EMPLOYEE,body: params).then((json){
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

}