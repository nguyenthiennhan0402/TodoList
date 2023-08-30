

import '../base/base_event.dart';

class AddTodoEvent extends BaseEvent{
  late String content;
  AddTodoEvent(String content){
    this.content = content;
  }

}