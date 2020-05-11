class Employee {
  String departmentId;
  String departmentname;
  String employerId;
  String employerName;
  String employersalary;

  Employee(
      {this.departmentId,
      this.departmentname,
      this.employerId,
      this.employerName,
      this.employersalary});

  Employee.fromJson(Map<String, dynamic> json) {
    departmentId = json['dept_id'];
    departmentname = json['dept_name'];
    employerId = json['emp_id'];
    employerName = json['emp_name'];
    employersalary = json['emp_Sal'];
  }
}
