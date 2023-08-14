part of 'add_employee_bloc.dart';

class AddEmployeeState {

/// Employee Id
final int? id;

/// Employee name
final String name;

/// Employee role
final String role;

/// Employe date of joining
final DateTime? startDate;

/// Relieving date
final DateTime? endDate;

/// Employee model for handling the edit employee
final Employee? employee;

/// Employee form submission state initial, laodin etc
final EmployeeFormSubmissionState employeeFormSubmissionState;

/// Employee deletion state
final EmployeeDeletionState employeeDeletionState;

const AddEmployeeState({
  this.id,
  this.name = '',
  this.role = '',
  this.startDate, 
  this.endDate,
  this.employee,
  this.employeeFormSubmissionState = EmployeeFormSubmissionState.initial,
  this.employeeDeletionState = EmployeeDeletionState.initial
  });

  AddEmployeeState copyWith({
    int? id,
    String? name,
    String? role,
    DateTime? startDate,
    DateTime? endDate,
    Employee? employee,
    EmployeeFormSubmissionState? employeeFormSubmissionState,
    EmployeeDeletionState? employeeDeletionState
  }) {
    return AddEmployeeState(
      id : id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      employee: employee ?? this.employee,
      employeeFormSubmissionState: employeeFormSubmissionState ?? this.employeeFormSubmissionState,
      employeeDeletionState: employeeDeletionState ?? this.employeeDeletionState
    );
  }

  /// Returns success message for insert and update employe data
  String getSuccessMessage(){
    return id == null ? kEmployeeAddedSuccessMessage : kEmployeeUpdateSuccessMessage;
  }

  /// Returns header title
  String getHeader(){
    return id == null ? kAddEmployee: kEditEmployee;
  }

}

/// Employee submission state
enum EmployeeFormSubmissionState{
  initial, submitting, success, failed
}

/// Employee deletion state
enum EmployeeDeletionState{
  initial, submitting, success, failed
}
