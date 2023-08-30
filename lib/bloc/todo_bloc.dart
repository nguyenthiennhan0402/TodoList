import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:todolist/base/base_bloc.dart';
import 'package:todolist/base/base_event.dart';
import 'package:todolist/db/todo_table.dart';
import 'package:todolist/event/add_todo_event.dart';
import 'package:todolist/event/delete_todo_event.dart';
import 'package:todolist/model/todo.dart';

class TodoBloc extends BaseBloc{
  TodoTable _todoTable = TodoTable();

  StreamController<List<Todo>> _todoListStreamController = StreamController<List<Todo>>() as StreamController<List<Todo>>;
  Stream<List<Todo>> get todoListStream => _todoListStreamController.stream;
  var _randomInt = Random();
  late List<Todo> _todoListData = [];

  initData() async {
    _todoListData = await _todoTable.selectAllTodo();
    if(_todoListData == null){
      return;
    }
    _todoListStreamController.sink.add(_todoListData);
  }
  _addTodo(Todo todo ) async {

      await _todoTable.insertTodo(todo);

      _todoListData.add(todo);
      _todoListStreamController.sink.add(_todoListData);
  }

  _deleteTodo(Todo todo) async{

    await _todoTable.deleteTodo(todo);
    _todoListData.remove(todo);
    _todoListStreamController.sink.add(_todoListData);
  }


  @override
  void dispatchEvent(BaseEvent event) {
    if(event is AddTodoEvent){
      print(event.content);
      Todo todo = Todo.fromData(1, event.content);
      _addTodo(todo);
    }
    else if (event is DeleteTodoEvent){
      _deleteTodo(event.todo);
    }
  }
  @mustCallSuper
  void dispose() {
    super.dispose();
    _todoListStreamController.close();

  }

}