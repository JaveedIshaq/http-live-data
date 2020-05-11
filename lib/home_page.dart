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
                  return ListTile(
                    leading: Text("${snapshot.data[index].departmentname}"),
                    title: Text('${snapshot.data[index].employerName}'),
                    subtitle:
                        Text("Employer Id: ${snapshot.data[index].employerId}"),
                    trailing:
                        Text("Salary: ${snapshot.data[index].employersalary}"),
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
