
import 'package:flutter/material.dart';
import 'package:todo_list/domain/entities/task.dart';

enum MainScreenStatus { initial, loading, success, failure, empty } 

@immutable
class MainScreenState {

  final MainScreenStatus statuse;
  final List<TaskEntity> tasks;

    const MainScreenState({ 
      required this.statuse, 
      required this.tasks, 
      });


  MainScreenState copyWith({
    MainScreenStatus? statuse,
    List<TaskEntity>? tasks,
  }) {
    return MainScreenState(
      statuse: statuse ?? this.statuse,
      tasks: tasks ?? this.tasks,
    );
  }
}