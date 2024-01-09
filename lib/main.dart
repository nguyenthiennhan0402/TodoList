import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/bloc/todo_bloc.dart';
import 'package:todolist/db/todo_database.dart';
import 'package:todolist/event/add_todo_event.dart';
import 'package:todolist/todolist.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await TodoDatabase.instance.init();
  runApp(
    MultiProvider(
      providers: [
        Provider<TodoBloc>.value(value: TodoBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TODO App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var txtTodoController = TextEditingController();
    var bloc = Provider.of<TodoBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List App'),
        centerTitle: true,
      ),
      body:Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: txtTodoController,
                    onChanged: (value) {
                    },
                    decoration: InputDecoration(
                      hintText: 'Add Todo',
                      labelText: 'Add Todo',
                    ),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(onPressed: (){
                  bloc.event.add(AddTodoEvent(txtTodoController.text));

                },
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                ),
                SizedBox(height: 16,),
              ],
            ),
            Expanded(child: Todolist()),
          ],
        ),
      ),
    );
  }
}


