part of 'employees_list_bloc.dart';

sealed class EmployeesListEvent {
  const EmployeesListEvent();
}

class FetchEmployess extends EmployeesListEvent {
  FetchEmployess();
}

class DeleteEmployeeUsingId extends EmployeesListEvent {
  Employee employee;
  DeleteEmployeeUsingId(this.employee);
}

class RestoreEmployee extends EmployeesListEvent {
  RestoreEmployee();
}