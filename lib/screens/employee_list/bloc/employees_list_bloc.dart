import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employees_app/models/employee.dart';
import 'package:employees_app/repository/employees_repository.dart';
import 'package:employees_app/screens/add_employee/bloc/add_employee_bloc.dart';
import 'package:employees_app/screens/employee_list/bloc/employees_fetching_state.dart';

part 'employees_list_event.dart';
part 'employees_list_state.dart';

class EmployeesListBloc extends Bloc<EmployeesListEvent, EmployeesListState> {
  final EmployeesRepository repo;
  EmployeesListBloc(this.repo) : super(const EmployeesListState()) {
    on<FetchEmployess>(_onFetchEmployees);
    on<DeleteEmployeeUsingId>(_onDeleteEmployeeUsingId);
    on<RestoreEmployee>(_onRestoreEmployee);
  }

  FutureOr<void> _onFetchEmployees(FetchEmployess event, Emitter<EmployeesListState> emit) async{
      emit(state.copyWith(employeesFetchingState: const EmployeesFetchingStateStarted()));
      try {
        List<Employee> employees =  repo.getAllEmployees();
        emit(state.copyWith(employees: employees, employeesFetchingState: const EmployeesFetchingStateSuccess()));
      } catch (e) {
        emit(state.copyWith(employeesFetchingState: const EmployeesFetchingStateFailed()));
      }
  }

  FutureOr<void> _onDeleteEmployeeUsingId(DeleteEmployeeUsingId event, Emitter<EmployeesListState> emit) async{
    emit(state.copyWith(employeeDeletionState: EmployeeDeletionState.submitting));
      try {
        Employee e = event.employee;
        e.isDeleted =  true;
        await repo.updateEmployee(e);
        List<Employee> employees = state.employees;
        employees.remove(e);
        emit(state.copyWith(employees: employees, lastDeletedEmployee: e, employeeDeletionState: EmployeeDeletionState.success));
        emit(state.copyWith(lastDeletedEmployee: e, employeeDeletionState: EmployeeDeletionState.initial));
      } catch (e) {
        emit(state.copyWith(employeeDeletionState: EmployeeDeletionState.failed));
      }
  }

  FutureOr<void> _onRestoreEmployee(RestoreEmployee event, Emitter<EmployeesListState> emit) async{
    try {
      if(state.lastDeletedEmployee != null){
        Employee e = state.lastDeletedEmployee!;
        e.isDeleted =  false;
        await repo.updateEmployee(e);
      }
    } catch (e) {}
  }
}
