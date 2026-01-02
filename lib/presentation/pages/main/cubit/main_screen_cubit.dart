import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/domain/repo/task_repo.dart';
import 'package:todo_list/presentation/pages/main/cubit/main_screen_state.dart';
import 'package:todo_list/service_locator.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit(super.initialState);
  final TaskRepository _taskRepository = sl<TaskRepository>();

  void initialize() {
    emit(state.copyWith(statuse: MainScreenStatus.loading));
    refreshTasks();
  }



  void toggleTaskCompletion(String taskId) async {
    _taskRepository.toggleTask(taskId);
    refreshTasks();
  }

  void refreshTasks() {
    _taskRepository
        .getAllTasks()
        .then((tasks) {
          if (tasks.isEmpty) {
            emit(state.copyWith(statuse: MainScreenStatus.empty));
          } else {
            emit(
              state.copyWith(statuse: MainScreenStatus.success, tasks: tasks),
            );
          }
        })
        .catchError((error) {
          emit(state.copyWith(statuse: MainScreenStatus.failure));
        });
  }

  void deleteTask(String taskId) async {
    await _taskRepository.deleteTask(taskId);
    refreshTasks();
  }
}
