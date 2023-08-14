import 'package:employees_app/components/theme.dart';
import 'package:employees_app/repository/employees_repository.dart';
import 'package:employees_app/screens/employee_list/components/employee_list_screen.dart';
import 'package:employees_app/utils/constants.dart';
import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  /// repository initaialization
  final employeeRepository = EmployeesRepository();

  await employeeRepository.openBox();

  runApp(MyApp(employeeRepo: employeeRepository,));
}


class MyApp extends StatelessWidget {
  final EmployeesRepository employeeRepo;
  const MyApp({super.key, required this.employeeRepo});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: kEmployeeListTitle,
      theme: primaryTheme(),
      home: EmployeeListScreen(employeeRepository: employeeRepo,),
    );
  }
}