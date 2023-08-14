part of 'employees_list_bloc.dart';

class EmployeesListState {
final List<Employee> employees;
final EmployeesFetchingState employeesFetchingState;
final EmployeeDeletionState employeeDeletionState;
final Employee? lastDeletedEmployee;
const EmployeesListState({
    this.employees = const [],
    this.lastDeletedEmployee,
    this.employeesFetchingState = const EmployeesFetchingStateInitial(),
    this.employeeDeletionState = EmployeeDeletionState.initial
  });

  EmployeesListState copyWith({
    List<Employee>? employees,
    EmployeesFetchingState? employeesFetchingState,
    EmployeeDeletionState? employeeDeletionState,
    Employee? lastDeletedEmployee
  }) {
    return EmployeesListState(
      employees: employees ?? this.employees,
      lastDeletedEmployee: lastDeletedEmployee ?? this.lastDeletedEmployee,
      employeesFetchingState: employeesFetchingState ?? this.employeesFetchingState,
      employeeDeletionState: employeeDeletionState ?? this.employeeDeletionState
    );
  }

  List<Section> getSections(){
    List<Section> sections = [];
    if(employees.isEmpty) return sections;
    List<Employee> currentEmployees = [];
    List<Employee> previousEmployees = [];
    for(int i=0;i<employees.length;i++){
      final employee = employees[i];
      if (employee.endDate == null || employee.endDate!.isAfter(DateTime.now())){
        currentEmployees.add(employee);
      }else{
        previousEmployees.add(employee);
      }
    }
    if(currentEmployees.isNotEmpty) sections.add(Section(employess: currentEmployees, title: "Current Employees"));
    if(previousEmployees.isNotEmpty) sections.add(Section(employess: previousEmployees, title: "Previous Employees"));
    return sections;
  }

}

class Section {
  List<Employee> employess;
  String title;
  Section({
    required this.employess,
    required this.title,
  });
  
}

