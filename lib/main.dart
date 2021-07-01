import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(SfDataGridDemo());
}

class SfDataGridDemo extends StatefulWidget {
  SfDataGridDemo({Key? key}) : super(key: key);

  @override
  _SfDataGridDemoState createState() => _SfDataGridDemoState();
}

class _SfDataGridDemoState extends State<SfDataGridDemo> {
  late EmployeeDataSource _employeeDataSource;
  late CustomColumnSizer _customColumnSizer;

  @override
  void initState() {
    super.initState();
    _employeeDataSource = EmployeeDataSource(employees: populateData());
    _customColumnSizer = CustomColumnSizer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Syncfusion Flutter DataGrid'),
          ),
          body: SfDataGrid(
            source: _employeeDataSource,
            columnSizer: _customColumnSizer,
            columnWidthMode: ColumnWidthMode.auto,
            columns: <GridColumn>[
              GridColumn(
                  columnName: 'ID',
                  autoFitPadding: EdgeInsets.all(12.0),
                  label: Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text(
                        'ID',
                      ))),
              GridColumn(
                  columnName: 'Name',
                  autoFitPadding: EdgeInsets.all(12.0),
                  label: Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text(
                        'Name',
                      ))),
              GridColumn(
                  columnName: 'DOB',
                  autoFitPadding: EdgeInsets.all(12.0),
                  label: Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text(
                        'DOB',
                      ))),
              GridColumn(
                  columnName: 'Salary',
                  autoFitPadding: EdgeInsets.all(12.0),
                  label: Container(
                      padding: EdgeInsets.all(12.0),
                      alignment: Alignment.center,
                      child: Text('Salary'))),
            ],
          )),
    );
  }

  List<Employee> populateData() {
    return [
      Employee(10001, 'James', DateTime(1998, 08, 30), 20000),
      Employee(10002, 'Kathryn', DateTime(1956, 05, 01), 30000),
      Employee(10003, 'Lara', DateTime(1967, 04, 24), 15000),
      Employee(10004, 'Michael', DateTime(1980, 04, 14), 15000),
      Employee(10005, 'Martin', DateTime(1987, 11, 12), 15000),
      Employee(10006, 'Newberry', DateTime(1998, 08, 30), 15000),
      Employee(10007, 'Balnc', DateTime(1956, 05, 01), 15000),
      Employee(10008, 'Perry', DateTime(1967, 04, 24), 15000),
      Employee(10009, 'Gable', DateTime(1980, 04, 14), 15000),
      Employee(10010, 'Grimes', DateTime(1987, 11, 12), 15000)
    ];
  }
}

class Employee {
  Employee(this.id, this.name, this.dob, this.salary);

  final int id;

  final String name;

  final DateTime dob;

  final int salary;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    _employeeData = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'ID', value: e.id),
              DataGridCell<String>(columnName: 'Name', value: e.name),
              DataGridCell<DateTime>(columnName: 'DOB', value: e.dob),
              DataGridCell<int>(columnName: 'Salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      late String cellValue;
      if (e.columnName == 'DOB') {
        cellValue = DateFormat.yMMMMd('en_US').format(e.value);
      } else if (e.columnName == 'Salary') {
        cellValue =
            NumberFormat.simpleCurrency(decimalDigits: 0).format(e.value);
      } else {
        cellValue = e.value.toString();
      }

      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(12.0),
        child: Text(cellValue),
      );
    }).toList());
  }
}

class CustomColumnSizer extends ColumnSizer {
  @override
  double computeCellWidth(GridColumn column, DataGridRow row, Object? cellValue,
      TextStyle textStyle) {
    if (column.columnName == 'DOB') {
      cellValue = DateFormat.yMMMMd('en_US').format(cellValue as DateTime);
    } else if (column.columnName == 'Salary') {
      cellValue =
          NumberFormat.simpleCurrency(decimalDigits: 0).format(cellValue);
    }

    return super.computeCellWidth(column, row, cellValue, textStyle);
  }
}
