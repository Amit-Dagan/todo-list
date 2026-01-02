enum Status { intial, loading, success, failure }

class AddTaskState {
  final Status status;

  AddTaskState({required this.status});

  AddTaskState copyWith({Status? status}) {
    return AddTaskState(status: status ?? this.status);
  }
}
