import 'package:employees_app/components/app_action_button.dart';
import 'package:employees_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ActionBar extends StatefulWidget {

  /// Date String
  final String date;

  /// Height of the action bar
  final double height;

  /// callback triggerd while on click save button
  final Function() onSave;

  /// callback triggerd while on click cancel button
  final Function() onCancel;

  final bool showCalendar;

  const ActionBar({super.key, this.height = 60, this.showCalendar = false, this.date = "", required this.onSave, required this.onCancel});

  @override
  State<ActionBar> createState() => _ActionBarState();
}

class _ActionBarState extends State<ActionBar> {

  @override
  Widget build(BuildContext context) {
    return 
      SizedBox(height: widget.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: kSectionHeaderColor,
              height: 2,
            ),
            const SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(visible: widget.showCalendar, child: Row(children: [
                  const SizedBox(width: 10,),
                  const Icon(Icons.event_outlined, color: kPrimaryColor,),
                  const SizedBox(width: 10,),
                  Text(widget.date)
                ],),),
                Row(children: [
                  AppActionButton(
                    width: 73,
                    title: kCancelButtonTitle,
                    textColor: kPrimaryColor,
                    backgroundColor: kSecondaryColor,
                    onPressed: widget.onCancel),
                const SizedBox(
                  width: 20,
                ),
                AppActionButton(
                    width: 73,
                    title: kSaveButtonTitle,
                    backgroundColor: kPrimaryColor,
                    onPressed: widget.onSave),
                const SizedBox(
                  width: 16,
                ),
                ],)
              ],
            ),
            const SizedBox(
              height: 5,
            )
          ],
        ));
  }
}