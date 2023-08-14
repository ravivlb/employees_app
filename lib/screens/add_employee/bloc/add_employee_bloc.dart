import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employees_app/models/employee.dart';
import 'package:employees_app/repository/employees_repository.dart';
import 'package:employees_app/utils/constants.dart';

part 'add_employee_event.dart';
part 'add_employee_state.dart';

class AddEmployeeBloc extends Bloc<AddEmployeeEvent, AddEmployeeState> {
  EmployeesRepository repo;
  AddEmployeeBloc(this.repo) : super(const AddEmployeeState()) {
  on<UpdateEmployeeValue>(_onUpdateEmployeeValue);
  on<NameValueChanged>(_onNameValueChanged);
  on<RoleValueChanged>(_onRoleValueChanged);
  on<StartDateValueChanged>(_onStartDateValueChanged);
  on<EndDateValueChanged>(_onEndDateValueChanged);
  on<SubmitEmployeeForm>(_onSubmitEmployeeForm);
  }

  FutureOr<void> _onNameValueChanged(NameValueChanged event, Emitter<AddEmployeeState> emit) {
    emit(state.copyWith(name: event.name));
  }

  FutureOr<void> _onRoleValueChanged(RoleValueChanged event, Emitter<AddEmployeeState> emit) {
      emit(state.copyWith(role: event.role));

  }

  FutureOr<void> _onStartDateValueChanged(StartDateValueChanged event, Emitter<AddEmployeeState> emit) {
      emit(state.copyWith(startDate: event.startDate));
  }

  FutureOr<void> _onEndDateValueChanged(EndDateValueChanged event, Emitter<AddEmployeeState> emit) {
      emit(state.copyWith(endDate: event.endDate));
  }

  FutureOr<void> _onUpdateEmployeeValue(UpdateEmployeeValue event, Emitter<AddEmployeeState> emit) {
    if(event.employee != null){
      Employee employee = event.employee!;
      emit(state.copyWith(id: employee.id, name:employee.name, role: employee.role, startDate: employee.startDate, endDate: employee.endDate, employee: employee));
    }
  }

  FutureOr<void> _onSubmitEmployeeForm(SubmitEmployeeForm event, Emitter<AddEmployeeState> emit) async{
    emit(state.copyWith(employeeFormSubmissionState: EmployeeFormSubmissionState.submitting));
    try {
      Employee employee = Employee(name: state.name, role: state.role, startDate: state.startDate ?? DateTime.now(), endDate: state.endDate);
      if(state.id == null){
        await repo.insertEmployee(employee);
      }else{
        employee.id = state.id!;
        await repo.updateEmployee(employee);
      }
      emit(state.copyWith(employeeFormSubmissionState: EmployeeFormSubmissionState.success));
    } catch (e) {
      emit(state.copyWith(employeeFormSubmissionState: EmployeeFormSubmissionState.failed));
      emit(state.copyWith(employeeFormSubmissionState: EmployeeFormSubmissionState.initial));
    }
  }
}
