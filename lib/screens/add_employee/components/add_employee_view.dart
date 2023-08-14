import 'package:employees_app/components/action_bar.dart';
import 'package:employees_app/components/app_text_field.dart';
import 'package:employees_app/components/calendar_view.dart';
import 'package:employees_app/components/rolers_picker.dart';
import 'package:employees_app/models/employee.dart';
import 'package:employees_app/screens/add_employee/bloc/add_employee_bloc.dart';
import 'package:employees_app/utils/constants.dart';
import 'package:employees_app/utils/date_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEmployeeView extends StatefulWidget {
  final Employee? employee;
  const AddEmployeeView({super.key, this.employee});

  @override
  State<AddEmployeeView> createState() => _AddEmployeeViewState();
}

class _AddEmployeeViewState extends State<AddEmployeeView> {
  /// Name text controller
  final nameTextController = TextEditingController();

  /// Role dropdown textfield controller
  final roleTextController = TextEditingController();

  /// Date of joing text ccontoller
  final startDateTextController = TextEditingController();

  /// Relieving date text controller
  final endDateTextController = TextEditingController();

  /// Globla key for form access
  /// which
  /// helps to access form elment and validations
  final _formKey = GlobalKey<FormState>();

  /// This state handled for view loaded
  bool isLoaded = false;

  /// Setup controller for all textfield
  /// to access at run time
  void setupTextControllers() {
    if (widget.employee == null || isLoaded) return;
    isLoaded = true;
    nameTextController.text = widget.employee?.name ?? '';
    roleTextController.text = widget.employee?.role ?? '';
    startDateTextController.text =
        widget.employee?.startDate.convertAppTextFieldFromatDate() ?? '';
    endDateTextController.text =
        widget.employee?.endDate?.convertAppTextFieldFromatDate() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    setupTextControllers();
    return BlocBuilder<AddEmployeeBloc, AddEmployeeState>(
      builder: (blocContext, state) {
        return SafeArea(
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          getNameTextField(blocContext),
                          const SizedBox(
                            height: 23,
                          ),
                          getRoleTextField(blocContext),
                          const SizedBox(
                            height: 23,
                          ),
                          Row(
                            children: [
                              Expanded(
                                  flex: 3, child: getDOJTextField(blocContext)),
                              const Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.east,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Expanded(
                                  flex: 3, child: getRDTextField(blocContext))
                            ],
                          )
                        ],
                      ),
                    ),
                    getActionBar(blocContext)
                  ],
                )));
      },
    );
  }

  /// Returns name text field with all properties
  /// hanlded `onChanged` and `validator`
  AppTextField getNameTextField(BuildContext blocContext) {
    return AppTextField(
      controller: nameTextController,
      hintText: kNamePlaceholder,
      prefix: const Icon(
        Icons.person_outlined,
        color: kPrimaryColor,
      ),
      onChanged: (p0) {
        BlocProvider.of<AddEmployeeBloc>(blocContext)
            .add(NameValueChanged(p0 ?? ''));
      },
      validator: (p0) =>
          BlocProvider.of<AddEmployeeBloc>(blocContext).state.name.isEmpty
              ? kNameVlidatationMessage
              : null,
    );
  }

  /// Returns role text field with all properties
  /// customesd design like drop down
  /// hanlded `onChanged` and `validator`
  AppTextField getRoleTextField(BuildContext blocContext) {
    return AppTextField(
      controller: roleTextController,
      readOnly: true,
      hintText: kRolePlaceholder,
      prefix: const Icon(
        Icons.work_outline_outlined,
        color: kPrimaryColor,
      ),
      suffix: const Icon(
        Icons.arrow_drop_down,
        color: kPrimaryColor,
      ),
      onTpped: () => showRolesBottomSheet(blocContext),
      onChanged: (p0) {},
      validator: (p0) =>
          BlocProvider.of<AddEmployeeBloc>(blocContext).state.role.isEmpty
              ? kROleValidationMessage
              : null,
    );
  }

  /// Dat of joining date field with all properties
  /// hanlded `onTaped` which shows the customized calender
  AppTextField getRDTextField(BuildContext blocContext) {
    return AppTextField(
      readOnly: true,
      controller: endDateTextController,
      hintText: kNoDatePlaceholder,
      prefix: const Icon(
        Icons.event_outlined,
        color: kPrimaryColor,
      ),
      validator: (p0) {},
      onTpped:
          BlocProvider.of<AddEmployeeBloc>(blocContext).state.startDate == null
              ? null
              : () {
                  showCalender(DateType.end, blocContext);
                },
    );
  }

  /// Relieving date field with all properties
  /// hanlded `onTaped` which shows the customized calender
  AppTextField getDOJTextField(BuildContext blocContext) {
    return AppTextField(
        readOnly: true,
        controller: startDateTextController,
        hintText: kTodayPlaceholder,
        prefix: const Icon(
          Icons.event_outlined,
          color: kPrimaryColor,
        ),
        onTpped: () {
          showCalender(DateType.start, blocContext);
        },
        validator: (p0) => null
        // BlocProvider.of<AddEmployeeBloc>(
        //                 context)
        //             .state
        //             .startDate ==
        //         null
        //     ? "Please select date"
        //     : null,
        );
  }

  /// Shows the customized calendar with some
  /// customized actions
  /// `type` - doj or relieving date
  Future<dynamic> showCalender(DateType type, BuildContext mycontext) {
    return showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CalendarView(
            startDate: type == DateType.end
                ? BlocProvider.of<AddEmployeeBloc>(mycontext).state.startDate
                : null,
            type: type,
            onSaveDate: (p0) {
              handleDateChanges(p0, type, mycontext);
            },
          );
        });
  }

  /// Handling the date changes
  void handleDateChanges(DateTime? p0, DateType type, BuildContext mycontext) {
    String dateString = p0?.convertAppTextFieldFromatDate() ?? '';
    if (type == DateType.start) {
      startDateTextController.text = dateString;
      BlocProvider.of<AddEmployeeBloc>(mycontext)
          .add(StartDateValueChanged(p0));
    } else {
      endDateTextController.text = dateString;
      BlocProvider.of<AddEmployeeBloc>(mycontext).add(EndDateValueChanged(p0));
    }
  }

  /// Returns action bar
  Widget getActionBar(BuildContext blocContext) {
    return ActionBar(
        height: 60,
        onSave: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<AddEmployeeBloc>(blocContext).add(SubmitEmployeeForm());
          }
        },
        onCancel: () {
          Navigator.of(context).pop();
        });
  }

  /// Show roles roles picker
  /// Listing all the roles
  ///
  void showRolesBottomSheet(BuildContext mycontext) {
    showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        builder: (BuildContext context) {
          return RolePicker(onRoleSelected: (p0) {
            roleTextController.text = p0;
            BlocProvider.of<AddEmployeeBloc>(mycontext)
                .add(RoleValueChanged(p0));
          });
        });
  }

  @override
  void dispose() {
    super.dispose();

    /// Dispose all the text controller memory
    nameTextController.dispose();
    roleTextController.dispose();
    startDateTextController.dispose();
    endDateTextController.dispose();
  }
}
