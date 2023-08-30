

import 'package:todolist/model/todo.dart';

import '../base/base_event.dart';

class DeleteTodoEvent extends BaseEvent{
    late Todo todo;
    DeleteTodoEvent(this.todo){
    }
}