
// There are 7 steps in BLoC pattern to achieve

// 1. TODO: imports

// 2. TODO: List of Employees
// 3. TODO: Stream Controllers

// 4. TODO: Stream Sink Getter

// 5. TODO: Constructor - add data; listen to changes

// 6. TODO: Core functions

// 7. TODO: Dispose


// 1. TODO:

import 'dart:async';
import 'employee.dart';

class EmployeeBloc {

  // 2. TODO:

  // Notes: 
  /*
    Sink to add in pipe
    Stream to get data from pipe
    By pipe we mean data flow
  */

  List<Employee> _employeeList = [
    Employee(1, 'Employee 1', 10000.0),
    Employee(2, 'Employee 2', 10330.0),
    Employee(3, 'Employee 3', 18000.0),
    Employee(4, 'Employee 4', 16000.0),
    Employee(5, 'Employee 5', 14000.0),
    Employee(6, 'Employee 6', 13000.0),
  ];

  // 3. TODO:
  // Stream controller for employee
  final _employeeListSteamController = StreamController<List<Employee>>();
  
  // for salary increment and decrement
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  // 4. TODO:

  // For employee
  Stream<List<Employee>> get employeeListStream => _employeeListSteamController.stream;
  StreamSink<List<Employee>> get employeeListSink => _employeeListSteamController.sink;

  // For increment and decrement
  StreamSink<Employee> get employeeSalaryIncrementSink => _employeeSalaryIncrementStreamController.sink;
  StreamSink<Employee> get employeeSalaryDecrementSink => _employeeSalaryDecrementStreamController.sink;

  // 5. TODO:
  EmployeeBloc() {
    _employeeListSteamController.add(_employeeList);
    
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  // 6. TODO:

  _incrementSalary(Employee e) {
    double salary = e.salary;

    double incrementedSalary = salary * 20 / 100;
    incrementedSalary = incrementedSalary + salary;
    _employeeList[e.id-1].salary = num.parse(incrementedSalary.toStringAsFixed(2));
    // Adding the updated data to the sink
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee e) {
    double salary = e.salary;

    double decrementedSalary = salary * 20 / 100;
    decrementedSalary = salary - decrementedSalary;
    _employeeList[e.id-1].salary = num.parse(decrementedSalary.toStringAsFixed(2));
    // Adding the updated data to the sink
    employeeListSink.add(_employeeList);
  }

  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListSteamController.close();
  }

}