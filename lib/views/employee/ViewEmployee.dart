import 'package:flutter/material.dart';
import 'package:mvvmproject/resources/UrlResources.dart';
import 'package:provider/provider.dart';
import '../../providers/EmployeeProvider.dart';
import '../auth/LoginScreen.dart';

class ViewEmployee extends StatefulWidget {

  @override
  State<ViewEmployee> createState() => _ViewEmployeeState();
}

class _ViewEmployeeState extends State<ViewEmployee> {
  EmployeeProvider provider;

  fetchProducts() async {
    await provider.allemployees(context);
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<EmployeeProvider>(context,listen:false);
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<EmployeeProvider>(context,listen:true);
    return Scaffold(
      appBar: AppBar(
        title: Text("View Employee"),
      ),
      body: (provider.alldata != null) ? ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: provider.alldata.length,
        itemBuilder: (context, index) {
          return
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Card(
                elevation: 10,
                color: Colors.white,
                child: ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Column(
                      children: [
                        Text("E-name = "+provider.alldata[index].ename.toString(),style: TextStyle(fontSize: 20),),
                        Text("Salary = "+provider.alldata[index].salary.toString(),style: TextStyle(fontSize: 20),),
                        Text("Department = "+  provider.alldata[index].department.toString(),style: TextStyle(fontSize: 20),),
                        SizedBox(height: 18),
                        GestureDetector(
                          onTap: ()  async{
                            // delete product normal (post) ..3
                            AlertDialog alert = new AlertDialog(
                              title: Center(child: Text("ALert !")),
                              content: Text("You Want To Delete !"),
                              actions: [
                                Row(
                                  children: [
                                    TextButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    },
                                        child: Text("Cancel")
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                      Uri url = Uri.parse(UrlResources.DELETE_EMPLOYEE);
                                      Map<String,String> params = {
                                        "eid":provider.alldata[index].eid.toString()
                                      };
                                      await provider.deleteemployee(context,params);
                                      if(provider.isdeleted)
                                      {
                                        await provider.allemployees(context);
                                      }
                                      else
                                      {
                                        print("employees Not Deleted");
                                      }
                                      Navigator.of(context).pop();
                                    }, child: Text("Delete")),
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
                          child: Container(
                              width: 160,
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.black,
                              ),
                              child: Center(child: Text("Delete Employee",style: TextStyle(color: Colors.white),))),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Editproduct()));
                        },
                        child: Container(
                            color: Colors.red,
                            height: 100,
                            width:130,
                            child: Text("Edit")),
                      ),

                    ],
                  ),
                ),
              ),
            );
        },
      ) : Center(child: CircularProgressIndicator()),
    );
  }
}
