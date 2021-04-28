import 'package:flutter/material.dart';
import 'package:todoSqlite/db/db.provider.dart';
import 'package:todoSqlite/model/task.model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTodoApp(),
    );
  }
}

class MyTodoApp extends StatefulWidget {
  MyTodoApp({Key key}) : super(key: key);

  @override
  _MyTodoAppState createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {
  // let's start by creating the Color variable
  Color mainColor = Color(0xFF0d0952);
  Color secondColor = Color(0xFF212061);
  Color btnColor = Color(0xFFff955b);
  Color editorColor = Color(0xFF4044cc);

  // The text field and insert ot into our table
    TextEditingController inputController = TextEditingController();
    String newTaskTxt = "";
  // now Let's make the getting function to get all the list from the Table
  getTasks() async {
    final tasks = await DBProvider.dataBase.getTask();
    print(tasks);
    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mainColor,
        title: Text('My To-Do!'),
      ),
      body: Column(
        children: [
          // Creating the list view
          Expanded(
              child: FutureBuilder(
            future: getTasks(),
            builder: (_, taskData) {
              switch (taskData.connectionState) {
                case ConnectionState.waiting:
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                case ConnectionState.done:
                  {
                    if (taskData.data != Null) {
                      return Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: taskData.data.length,
                            itemBuilder: (context, index) {
                              String task =
                                  taskData.data[index]['task'].toString();
                              String day = DateTime.parse(
                                      taskData.data[index]['creationDate'])
                                  .day
                                  .toString();
                              // return something
                              return Card(
                                color: secondColor,
                                child: InkWell(
                                  onTap: (){},
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 12.0),
                                        padding: EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(8.0), 
                                        ),
                                        child: Text(day, style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.bold
                                        ),),
                                      ),
                                      Expanded(child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(task, style: TextStyle(color: Colors.white, fontSize: 16.0),),
                                      ))
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    }else{
                      return Center(child: Text('You have no Task Today', style: TextStyle(color: Colors.white54),),);
                    }
                  }

              }
            },
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
            decoration: BoxDecoration(
                color: editorColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0))),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                    controller: inputController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Type a new Task",
                        focusedBorder: InputBorder.none),
                )),
                SizedBox(
                  width: 15.0,
                ),
                FlatButton.icon(
                  label: Text('Add Task'),
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // insert data in table
                    setState(() {
                      newTaskTxt = inputController.text.toString();
                      inputController.text = "";
                    });
                    Task newTask = Task(task: newTaskTxt, dateTime: DateTime.now());
                    DBProvider.dataBase.addNewTask(newTask);
                    
                  },
                  color: btnColor,
                  shape: StadiumBorder(),
                  textColor: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
