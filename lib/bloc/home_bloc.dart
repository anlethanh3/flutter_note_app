import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/model/todo.dart';
import 'package:flutter_note_app/model/work.dart';
import 'package:flutter_note_app/repo/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeRepository repository;

  HomeBloc(this.repository);

  @override
  get initialState => DefaultHomeState();

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    if (event is InCompleteEvent) {
      yield InCompleteState(repository.getInComplete());
    } else if (event is CompleteEvent) {
      yield CompleteState(repository.getComplete());
    } else if (event is AllEvent) {
      yield AllState(repository.getAll());
    } else if (event is AddWorkEvent) {
      repository.addWork(event.work);
      repository.saveToDo();
      yield getUpdateState();
    } else if (event is UpdateWorkEvent) {
      repository.updateWork(event.work);
      repository.saveToDo();
      yield getUpdateState();
    } else if (event is DeleteWorkEvent) {
      repository.deleteWork(event.work);
      repository.saveToDo();
      yield getUpdateState();
    }
  }

  HomeState getUpdateState() {
    if (state is InCompleteState) {
      return InCompleteState(repository.getInComplete());
    } else if (state is CompleteState) {
      return CompleteState(repository.getComplete());
    }
    return AllState(repository.getAll());
  }
}

@immutable
abstract class HomeEvent {}

@immutable
abstract class HomeState {}

class InCompleteEvent extends HomeEvent {}

class DefaultHomeState extends HomeState {}

class InCompleteState extends HomeState {
  final ToDo toDo;

  InCompleteState(this.toDo);
}

class CompleteEvent extends HomeEvent {}

class CompleteState extends HomeState {
  final ToDo toDo;

  CompleteState(this.toDo);
}

class AllEvent extends HomeEvent {}

class AddWorkEvent extends HomeEvent {
  final Work work;

  AddWorkEvent(this.work);
}

class UpdateWorkEvent extends HomeEvent {
  final Work work;

  UpdateWorkEvent(this.work);
}

class DeleteWorkEvent extends HomeEvent {
  final Work work;

  DeleteWorkEvent(this.work);
}

class AllState extends HomeState {
  final ToDo toDo;

  AllState(this.toDo);
}
