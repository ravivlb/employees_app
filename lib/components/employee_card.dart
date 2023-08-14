import 'package:employees_app/models/employee.dart';
import 'package:employees_app/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EmployeeCard extends StatefulWidget {
  /// Required Employee model to display in card
  final Employee employee;

  /// Callback triggered while swipe to delete 
  final Function(BuildContext context) onDelete;

  const EmployeeCard(
      {super.key, required this.employee, required this.onDelete});

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),
        
        // closeOnScroll: true,
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: getSlideActions(),
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: getCard(),
        ));
  }

  /// Employee detail card which displays
  /// 
  /// name, role and dates
  Container getCard() {
    return Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.employee.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: kListTitleColor),
              ),
              Text(
                widget.employee.role,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: kListSubTitleTextColor),
              ),
              Text(
                widget.employee.getDateDescription(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: kListSubTitleTextColor),
              )
            ],
          ),
        );
  }

  /// Slideable action for delete
  List<SlidableAction> getSlideActions(){
    return [
      SlidableAction(
              onPressed: doNothing,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              icon: CupertinoIcons.delete,
            ),
      SlidableAction(
        onPressed: widget.onDelete,
        backgroundColor: const Color(0xFFFE4A49),
        foregroundColor: Colors.white,
        icon: CupertinoIcons.delete,
      ),
    ];
  }

  void doNothing(BuildContext context) {}
}

