import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/bloc/todo_bloc.dart';
import 'package:todolist/event/delete_todo_event.dart';
import 'package:todolist/model/todo.dart';

class Todolist extends StatefulWidget {
  const Todolist({Key? key}) : super(key: key);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var bloc = Provider.of<TodoBloc>(context);
    bloc.initData();
  }
  
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoBloc>(
      builder: (context, bloc, child) => StreamBuilder<List<Todo>>(
          stream: bloc.todoListStream,
          builder: (context, snapshot) {
            switch(snapshot.connectionState){
              case ConnectionState.active:
                return ListView.builder(
                  //snapshot là dữ liệu nhận được từ stream
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index].content,style: TextStyle(fontSize: 20),),
                        trailing: GestureDetector(
                          onTap: (){
                            bloc.event.add(DeleteTodoEvent(snapshot.data![index]));
                          },
                          child: Icon(
                              Icons.delete,
                              color: Colors.red[400]
                          ),
                        ),
                      );
                    });
              case ConnectionState.none:
              default:
                return Center(
                  child: Container(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(),
                  ),
                );
            }
            //switch
          }
      )
    );
  }
}
