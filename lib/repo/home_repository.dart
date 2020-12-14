import 'package:flutter_note_app/common/helper.dart';
import 'package:flutter_note_app/model/todo.dart';
import 'package:flutter_note_app/model/work.dart';

class HomeRepository {
  final Helper helper;

  HomeRepository(this.helper);

  ToDo getInComplete() {
    final todo = helper.todo.works.where((element) => !element.isDone).toList();
    return ToDo(works: todo);
  }

  ToDo getComplete() {
    final todo = helper.todo.works.where((element) => element.isDone).toList();
    return ToDo(works: todo);
  }

  ToDo getAll() {
    return ToDo(works: helper.todo.works);
  }

  void addWork(Work work) {
    helper.todo.works.add(Work(id: work.id,
        name: work.name,
        utcTime: work.utcTime,
        isDone: work.isDone));
  }

  void updateWork(Work work) {
    final item = helper.todo.works.firstWhere((element) => element.utcTime == work.utcTime);
    if(item != null){
      item.name = work.name;
      item.isDone = work.isDone;
    }
  }

  void deleteWork(Work work) {
    helper.todo.works.removeWhere((element) => element.utcTime == work.utcTime);
  }

  void saveToDo() {
    helper.save();
  }
}
