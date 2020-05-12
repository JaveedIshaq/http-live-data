import 'dart:convert';

import 'package:employees_flutter/model/employee.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      backgroundColor: Colors.teal[100],
      appBar: AppBar(
        title: Text("Employess"),
      ),
      body: FutureBuilder(
        future: _getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(0),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              // ListTile(
                              //   leading:
                              //       Text("${snapshot.data[index].departmentname}"),
                              //   title: Text('${snapshot.data[index].employerName}'),
                              //   subtitle: Text(
                              //       "Employer Id: ${snapshot.data[index].employerId}"),
                              //   trailing: Text(
                              //       "Salary: ${snapshot.data[index].employersalary}"),
                              // ),
                              Column(
                                children: <Widget>[
                                  Text('${snapshot.data[index].employerName}'),
                                  SizedBox(height: 5.0),
                                  Text(
                                    "${snapshot.data[index].departmentname}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "Salary: ${snapshot.data[index].employersalary}",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Text("15m"),
                                    Icon(Icons.star)
                                  ],
                                ),
                              )
                            ],
                          ),
                          Divider(
                            height: 5,
                            color: Colors.black87,
                          )
                        ],
                      ),
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
