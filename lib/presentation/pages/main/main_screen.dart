import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/style/app_colors.dart';
import 'package:todo_list/presentation/pages/main/cubit/main_screen_cubit.dart';
import 'package:todo_list/presentation/pages/main/cubit/main_screen_state.dart';
import 'package:todo_list/presentation/pages/main/widgets/add_task_button.dart';
import 'package:todo_list/presentation/pages/main/widgets/get_started.dart';
import 'package:todo_list/presentation/pages/main/widgets/task_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => MainScreenCubit(
        MainScreenState(statuse: MainScreenStatus.initial, tasks: []),
      )..initialize(),
      child: Scaffold(
      floatingActionButton: AddTaskButton(
          onPressed: () async {
            Navigator.pushNamed(context, '/addTask');
          },
        ),
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          title: const Text(
            'TODO APP',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: BlocBuilder<MainScreenCubit, MainScreenState>(
          builder: (context, state) {
            switch (state.statuse) {
              case MainScreenStatus.initial:
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );

              case MainScreenStatus.loading:
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );

              case MainScreenStatus.success:
                final allTasks = state.tasks;

                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),

                  itemCount:
                      state.tasks.length,

                  itemBuilder: (context, index) {
                    final task = allTasks[index];
                    return Dismissible(
                      onDismissed: (direction) {
                        context.read<MainScreenCubit>().deleteTask(task.id);
                      },
                      key: ValueKey(task.id),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TaskWidget(
                          task: task,
                          onToggle: (value) {
                            context.read<MainScreenCubit>().toggleTaskCompletion(
                              task.id,
                            );
                          },
                        ),
                      ),
                    );
                  },
                );

              case MainScreenStatus.failure:
                return const Center(child: Text('An error occurred'));

              case MainScreenStatus.empty:
                return Center(child: GetStarted());
            }
          },
        ),
      ),
    );
  }
}
