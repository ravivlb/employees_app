import 'package:employees_app/components/employee_card.dart';
import 'package:employees_app/models/employee.dart';
import 'package:employees_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SectionListView extends StatefulWidget {

  /// Title of the header section
  final String title;

  /// Employees array 
  final List<Employee> employees;

  /// Callback function triggered while click list card
  /// which
  /// pass the employee data to parent
  final Function(Employee) onTapped;

  /// Callback function triggered while click list card
  /// which
  /// pass the employee data to parent
  final Function(Employee) onDelete;

  const SectionListView(
      {super.key,
      required this.title,
      required this.employees,
      required this.onTapped,
      required this.onDelete});

  @override
  State<SectionListView> createState() => _SectionListViewState();
}

class _SectionListViewState extends State<SectionListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _sectionView(widget.title),
        _listView(widget.employees)],
    );
  }

  /// Section header view which diplayes header title
  /// `title` title of the header section
  Widget _sectionView(String title) {
    return SizedBox(
        width: double.infinity,
        height: 56,
        child: Container(
            color: kSectionHeaderColor,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kPrimaryColor),
              ),
            )));
  }
  /// Listview with separator to list 
  /// the employee data card
  Widget _listView(List<Employee> employees) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
            thickness: 1,
            color: kSectionHeaderColor,
          );
        },
        physics: const NeverScrollableScrollPhysics(),
        itemCount: employees.length,
        itemBuilder: (context, index) {
          Employee employee = employees[index];
          return GestureDetector(
            onTap: () {
              widget.onTapped(employee);
            },
            child: SizedBox(
                height: 104,
                width: double.infinity,
                child: EmployeeCard(
                  employee: employee,
                  onDelete: (context) {
                    widget.onDelete(employee);
                  },
                )),
          );
        });
  }
}
