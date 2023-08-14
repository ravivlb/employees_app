
import 'package:employees_app/utils/constants.dart';
import 'package:flutter/material.dart';

class RolePicker extends StatelessWidget {
  final Function(String) onRoleSelected;
  const RolePicker({super.key, required this.onRoleSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
                  height: 1,
                  thickness: 1,
                  color: kSectionHeaderColor,
                ),
            itemCount: employeeRoles.length,
            itemBuilder: (context, index) {
              String role = employeeRoles[index];
              return ListTile(
                title: Center(
                    child: Text(
                  role,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: kListTitleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                )),
                onTap: () {
                  onRoleSelected(role);
                  Navigator.pop(context);
                },
              );
            }));
  }
}
