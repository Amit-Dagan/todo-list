import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/domain/entities/task.dart';
import 'package:todo_list/domain/repo/task_repo.dart';
import 'package:todo_list/presentation/pages/add_task/cubit/add_task_state.dart';
import 'package:todo_list/service_locator.dart';
import 'package:uuid/uuid.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  final TaskRepository _taskRepository = sl<TaskRepository>();
  AddTaskCubit() : super(AddTaskState(status: Status.intial));
  final uuid = Uuid(); // i could have used sl but this is simpler for one use

  Future<void> addTask(String taskTitle) async {
    if (taskTitle.trim().isEmpty) {
      emit(state.copyWith(status: Status.intial));
      return;
    }

    emit(state.copyWith(status: Status.loading));

    try {
      final task = TaskEntity(
        description: taskTitle.trim(),
        isCompleted: false,
        id: uuid.v4(),
      );
      await _taskRepository.addTask(task);
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
