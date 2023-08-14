import 'dart:async';
import 'package:employees_app/models/employee.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path/path.dart' as path;
import 'package:employees_app/objectbox.g.dart';
class EmployeesRepository {
  late final Store _store;
  late final Box<Employee> _employeeBox;

  Future<void> openBox() async {
    /// File path for create database file
    final appDocumentsDirextory =
        await path_provider.getApplicationDocumentsDirectory();
    
    /// Open the Objectbox databae
    _store = await Store(
      getObjectBoxModel(),
      directory: path.join(appDocumentsDirextory.path, 'employess-db'),
    );

    /// Define the employee entity
    _employeeBox = Box<Employee>(_store);
  }

  /// Close database opearions
  Future<void> closeBox() async {
    _store.close();
  }

  /// Create new employee record
  /// in 
  /// Objectbox databaase
  Future<void> insertEmployee(Employee employee) async {
    await _employeeBox.put(employee);
  }

  /// Return employee record based on the employee Id
  Employee? getEmployee(int id) {
    return _employeeBox.get(id);
  }

  /// Return all active employees records
  List<Employee> getAllEmployees() {
    return _employeeBox.query(Employee_.isDeleted.equals(false)).build().find();
  }

  /// Update employees record
  Future<void> updateEmployee(Employee employee) async {
    await _employeeBox.put(employee);
  }

  /// Delete employees record
  /// using
  /// `id` employee id
  Future<void> deleteEmployee(int id) async {
    await _employeeBox.remove(id);
  }
}
