import 'package:flutter/material.dart';
import 'package:flutter_dbapp/dbHelper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Database Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Database Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dbhelper = DatabaseHelper.instance;
  void insertdata() async{
    Map<String,dynamic> row = {
      DatabaseHelper.columnName: "Ajinkya",
      DatabaseHelper.columnNo : 30
    };
    final id = await dbhelper.insert(row);
    print(id);
  }

  void queryall() async{
    var allrow = await dbhelper.fetchall();
    allrow.forEach((row) {
      print(row);
    });
  }

  void getqueryById() async{
    var allrows = await dbhelper.getstudentById(30);
    print(allrows);
  }

  void deleteRow() async{
    var allrows = await dbhelper.deleteRow(1);
    print(allrows);
  }

  void update() async{
    var allrows = await dbhelper.update(2);
    print(allrows);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20,),
            RaisedButton(onPressed: insertdata,
              child: Text("Insert"),
            ),
            const SizedBox(height: 20,),
            RaisedButton(onPressed: queryall,
              child: Text("Fetch All"),
            ),
            const SizedBox(height: 20,),
            RaisedButton(onPressed: getqueryById,
              child: Text("Fetch By Id"),
            ),
            const SizedBox(height: 20,),
            RaisedButton(onPressed: deleteRow,
              child: Text("Delete by Id"),
            ),
            const SizedBox(height: 20,),
            RaisedButton(onPressed: update,
              child: Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
