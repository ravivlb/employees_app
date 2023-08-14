import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF1DA1F2);
const kTextColor = Color(0xFF757575);
const kSectionHeaderColor = Color(0xFFF2F2F2);
const kListSubTitleTextColor = Color(0xFF949C9E);
const kListTitleColor = Color(0xFF323238);
const kSecondaryColor = Color(0xFFEDF8FF);

const kFontFamily = "Roboto-Regular";

const employeeRoles = [
  "Product Desiner",
  "Flutter Developer",
  "QA Tester",
  "Product Owner"
];

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year-5, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year+5, kToday.month, kToday.day);

/// Images

const kNoDataImageBanner = "assets/images/no_data_image.png";

const kEmployeeListTitle = "Employee List";
const kEmployeeDeletedSuccessMessage = "Employee data has been deleted";
const kUndoButtonTitle = "Undo";
const kSwipeToDelete = "Swipe to left to delete";
const kNoRecordsFound = "No employee records found";
const kEmployeeAddedSuccessMessage = "Employee added sucessfully";
const kEmployeeUpdateSuccessMessage = "Employee updated successfully";
const kAddEmployee = "Add Employee Details";
const kEditEmployee = "Edit Employee Details";
const kOops = "Oops! something went wrong";
const kNoDatePlaceholder = "No Date";
const kTodayPlaceholder = "Today";
const kNameVlidatationMessage = "Please enter name";
const kROleValidationMessage = "Please select role";
const kRolePlaceholder = "Select role";
const kNamePlaceholder = "Employee name";
const kCancelButtonTitle = "Cacel";
const kSaveButtonTitle = "Save";
const kTodayButtonTitle = "Today";
const kNextMondayTitle = "Next Monday";
const kNextTuesdayTitle = "Next Tuesday";
const kAfter1WeekTitle = "After 1 week";