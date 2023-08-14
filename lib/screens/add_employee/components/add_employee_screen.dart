import 'package:employees_app/components/snack_bar.dart';
import 'package:employees_app/models/employee.dart';
import 'package:employees_app/repository/employees_repository.dart';
import 'package:employees_app/screens/add_employee/bloc/add_employee_bloc.dart';
import 'package:employees_app/screens/add_employee/components/add_employee_view.dart';
import 'package:employees_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeScreen extends StatefulWidget {
  /// Employee model
  final Employee? employee;

  /// Employee repository to handle local databse operations
  final EmployeesRepository employeRepository;

  /// Callback trigger once emplyee ne data inseted
  /// and
  /// updated the existing data
  final Function() didUpdatedEmployee;

  /// callback triggerd once click the delete icon
  /// which enbaled only for edit flow
  final Function(Employee) didEmployeeDeleted;

  const AddEmployeeScreen(
      {super.key,
      this.employee,
      required this.employeRepository,
      required this.didEmployeeDeleted,
      required this.didUpdatedEmployee});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddEmployeeBloc(widget.employeRepository)
        ..add(UpdateEmployeeValue(widget.employee)),
      child: BlocConsumer<AddEmployeeBloc, AddEmployeeState>(
        listener: (context, state) {
          listenState(state);
        },
        builder: (mycontext, state) {
          return Scaffold(
            appBar: AppBar(
              title: getHeaderTitle(mycontext),
              actions: getAppBarActions(),
            ),
            body: AddEmployeeView(
              employee: widget.employee,
            ),
          );
        },
      ),
    );
  }

  Text getHeaderTitle(BuildContext mycontext) {
    return Text(BlocProvider.of<AddEmployeeBloc>(mycontext).state.getHeader());
  }

  List<IconButton> getAppBarActions() {
    return widget.employee == null ? [] : [getDeleteAction(context)];
  }

  IconButton getDeleteAction(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (widget.employee == null) return;
          widget.didEmployeeDeleted(widget.employee!);
          Navigator.of(context).pop();
        },
        icon: const Icon(
          CupertinoIcons.delete,
          color: Colors.white,
        ));
  }

  /// Listening bloc state for handling the success/failure
  void listenState(AddEmployeeState state) {
    if (state.employeeFormSubmissionState ==
        EmployeeFormSubmissionState.success) {
      String message = state.getSuccessMessage();
      widget.didUpdatedEmployee();

      /// Showing toast mesage
      AppSnackBar.show(context, message);
      Navigator.of(context).pop();
    }
    if (state.employeeFormSubmissionState ==
        EmployeeFormSubmissionState.failed) {
      AppSnackBar.show(context, kOops);
    }
  }
}
