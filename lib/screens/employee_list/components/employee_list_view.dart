import 'package:employees_app/components/section_list_view.dart';
import 'package:employees_app/models/employee.dart';
import 'package:employees_app/repository/employees_repository.dart';
import 'package:employees_app/screens/add_employee/components/add_employee_screen.dart';
import 'package:employees_app/screens/employee_list/bloc/employees_list_bloc.dart';
import 'package:employees_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeesListView extends StatefulWidget {

  /// Employeee repository to perform Local database operation
  final EmployeesRepository employeesRepository;

  const EmployeesListView({super.key, required this.employeesRepository});

  @override
  State<EmployeesListView> createState() => _EmployeesListViewState();
}

class _EmployeesListViewState extends State<EmployeesListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeesListBloc, EmployeesListState>(
      listener: (context, state) {},
      builder: (blocContext, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: getListView(state, blocContext)),
            SafeArea(child: getSwipeToLeftBanner())
          ],
        );
      },
    );
  }

  /// Returns swipe to delete banner in bottom of the view
  Container getSwipeToLeftBanner() {
    return Container(
      height: 50,
      width: double.infinity,
      color: kSectionHeaderColor,
      child: const Padding(
        padding: EdgeInsets.all(15.0),
        child: Text(
          kSwipeToDelete,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: kListSubTitleTextColor),
        ),
      ),
    );
  }

  ListView getListView(EmployeesListState state, BuildContext blocContext) {
    return ListView(
      children: state.getSections().map((e) {
        return SectionListView(
            title: e.title,
            employees: e.employess,
            onTapped: (employee) {
              navigateToAddMemberScreen(employee, blocContext);
            },
            onDelete: (employee) {
              deleteEmployee(employee, blocContext);
            });
      }).toList(),
    );
  }

  /// Naviagte to Add member screen to edit the employee data
  /// and
  /// pass the employee model to show the existing employee data
  void navigateToAddMemberScreen(Employee employee, BuildContext blocContext){
    Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AddEmployeeScreen(
                      employee: employee,
                      employeRepository: widget.employeesRepository,
                      didEmployeeDeleted: (p0) {
                        deleteEmployee(employee, blocContext);
                      },
                      didUpdatedEmployee: () {
                        fetchEmployees(blocContext);
                      })));
  }

  /// Triggering Delete employee data event
  void deleteEmployee(Employee employee, BuildContext blocContext) {
    BlocProvider.of<EmployeesListBloc>(blocContext)
        .add(DeleteEmployeeUsingId(employee));
  }

  /// Trigger to fetch all employees data
  void fetchEmployees(BuildContext blocContext){
    BlocProvider.of<EmployeesListBloc>(blocContext)
                            .add(FetchEmployess());
  }

}
