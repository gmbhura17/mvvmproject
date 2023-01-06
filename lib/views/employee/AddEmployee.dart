import 'package:flutter/material.dart';
import 'package:mvvmproject/providers/EmployeeProvider.dart';
import 'package:mvvmproject/views/employee/ViewEmployee.dart';
import 'package:provider/provider.dart';

class AddEmployee extends StatefulWidget {

  @override
  State<AddEmployee> createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {
  TextEditingController _ename  = TextEditingController();
  TextEditingController _salary  = TextEditingController();
  TextEditingController _department  = TextEditingController();
  EmployeeProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<EmployeeProvider>(context,listen:false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Employee"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            // Text("Product :"),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _ename ,
                // obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product',
                    hintText: 'Enter Your Product'
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            // Text("Price :"),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _salary,
                // obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    hintText: 'Enter Your price'
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            // Text("Quantity :"),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _department ,
                // obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Quantity',
                    hintText: 'Enter your quantity'
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: () async{
                var nam = _ename.text.toString();
                var sal = _salary.text.toString();
                var dep = _department.text.toString();
                // insert procduct normal -api  (post) ..1 product
                Map<String,String> params = {
                  "ename":nam,
                  "salary":sal,
                  "department":dep,
                };
                await provider.addemployee(context,params);
                if(provider.isinserted)
                {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ViewEmployee()));
                }
                else
                {
                  print("Errors");
                }
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text('Submit', style: TextStyle(color: Colors.white, fontSize: 25),),
                ),
              ),
            ),
            SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
