import 'dart:convert';

import 'package:employees_flutter/model/employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListGridDemo extends StatefulWidget {
  @override
  _ListGridDemoState createState() => _ListGridDemoState();
}

class _ListGridDemoState extends State<ListGridDemo> {
  List<Employee> employees = [];

  Future<List<Employee>> _getData() async {
    final response = await http.get(
        'https://unlabelled-argument.000webhostapp.com/db_dept_emp_info.php');

    if (response.statusCode == 200) {
      List parsed = jsonDecode(response.body);
      print("object=======================================");
      print(parsed);

      return parsed.map((emp) => Employee.fromJson(emp)).toList();
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text("Employees"),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(children: <Widget>[
                        Text("${snapshot.data[index].departmentname}"),
                        Text('${snapshot.data[index].employerName}'),
                        Text("Employer Id: ${snapshot.data[index].employerId}"),
                        Text("Salary: ${snapshot.data[index].employersalary}"),
                      ]),
                    ),
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
