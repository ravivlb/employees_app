import 'package:employees_app/components/no_data_view.dart';
import 'package:employees_app/repository/employees_repository.dart';
import 'package:employees_app/screens/add_employee/bloc/add_employee_bloc.dart';
import 'package:employees_app/screens/add_employee/components/add_employee_screen.dart';
import 'package:employees_app/screens/employee_list/bloc/employees_fetching_state.dart';
import 'package:employees_app/screens/employee_list/bloc/employees_list_bloc.dart';
import 'package:employees_app/screens/employee_list/components/employee_list_view.dart';
import 'package:employees_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListScreen extends StatefulWidget {

  /// Employee repository used to perform local databse operations
  final EmployeesRepository employeeRepository;

  const EmployeeListScreen({super.key, required this.employeeRepository});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (mycontext) =>
          EmployeesListBloc(widget.employeeRepository)..add(FetchEmployess()),
      child: BlocConsumer<EmployeesListBloc, EmployeesListState>(
        listener: (mycontext, state) {
          /// Verify the employee deletion status
          if (state.employeeDeletionState == EmployeeDeletionState.success) {
            showRestoreSnackBar(mycontext);
          }
        },
        builder: (blocContext, state) {
          return Scaffold(
              appBar: getAppBar(),
              floatingActionButton: getFloatingButton(blocContext),
              body: BlocBuilder<EmployeesListBloc, EmployeesListState>(
                builder: (context, state) {
                  return getBodyView(state);
                },
              ));
        },
      ),
    );
  }

  /// Appbar for header view
  AppBar getAppBar() {
    return AppBar(
              title: const Text(kEmployeeListTitle),
            );
  }

  /// Bottom floating button 
  /// which 
  /// naviagte to Add employee screen
  FloatingActionButton getFloatingButton(BuildContext blocContext) {
    return FloatingActionButton(
              shape: getRectangleShape(),
              backgroundColor: kPrimaryColor,
              child: const Icon(Icons.add),
              onPressed: () {
                navigateToAddEmployeeScreen(blocContext);
              },
            );
  }

  RoundedRectangleBorder getRectangleShape() {
    return const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)));
  }

  /// Return manincontent view
  /// `state` : EmployeesListState is bloc state 
  Widget getBodyView(EmployeesListState state){
    if (state.employeesFetchingState
                      is EmployeesFetchingStateStarted) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: kPrimaryColor,
                      ),
                    );
                  }
                  if ((state.employeesFetchingState
                              is EmployeesFetchingStateSuccess &&
                          state.employees.isEmpty) ||
                      state.employeesFetchingState
                          is EmployeesFetchingStateFailed) {
                    return const NoDataView();
                  }
                  return EmployeesListView(
                    employeesRepository: widget.employeeRepository,
                  );
  }

  /// Present snackbar with UNDO opetion
  /// UNDO helps to restore deleted employee data
  void showRestoreSnackBar(BuildContext blocContext){
    try {
            final snackBar = SnackBar(
            content: const Text(kEmployeeDeletedSuccessMessage),
            action: SnackBarAction(
              textColor: kPrimaryColor,
              label: kUndoButtonTitle,
              onPressed: () {
                restoreEmployee(blocContext);
              },
            ),
          );

          // Find the ScaffoldMessenger in the widget tree
          // and use it to show a SnackBar.
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } catch (e) {
            print(e);
          }
  }

  ///Restore last deleted employee data
  ///and 
  ///Fetch all the employess data
  void restoreEmployee(BuildContext blocContext){
    BlocProvider.of<EmployeesListBloc>(blocContext)
                  .add(RestoreEmployee());
    BlocProvider.of<EmployeesListBloc>(blocContext).add(FetchEmployess());
                // Some code to undo the change.
  }

  /// Routing to Add Employee Screen
  void navigateToAddEmployeeScreen(BuildContext blocContext){
    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddEmployeeScreen(
                            employeRepository: widget.employeeRepository,
                            didEmployeeDeleted: (p0) {},
                            didUpdatedEmployee: () {
                              BlocProvider.of<EmployeesListBloc>(blocContext)
                                  .add(FetchEmployess());
                            },
                          )));
  }

}
