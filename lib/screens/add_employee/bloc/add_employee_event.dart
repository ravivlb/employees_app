part of 'add_employee_bloc.dart';


sealed class AddEmployeeEvent {}

class UpdateEmployeeValue extends AddEmployeeEvent {
  Employee? employee;
  UpdateEmployeeValue(this.employee);
}

class NameValueChanged extends AddEmployeeEvent {
  String name;
  NameValueChanged(this.name);
}

class RoleValueChanged extends AddEmployeeEvent {
  String role;
  RoleValueChanged(this.role);
}

class StartDateValueChanged extends AddEmployeeEvent {
  DateTime? startDate;
  StartDateValueChanged(this.startDate);
}
class EndDateValueChanged extends AddEmployeeEvent {
  DateTime? endDate;
  EndDateValueChanged(this.endDate);
}

class SubmitEmployeeForm extends AddEmployeeEvent {
  SubmitEmployeeForm();
}


