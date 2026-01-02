import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/core/style/app_colors.dart';
import 'package:todo_list/presentation/pages/add_task/cubit/add_task_cubit.dart';
import 'package:todo_list/presentation/pages/add_task/cubit/add_task_state.dart';
import 'package:todo_list/presentation/pages/add_task/widgets/add_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddTaskCubit(),
      child: BlocListener<AddTaskCubit, AddTaskState>(
        listenWhen: (prev, curr) => prev.status != curr.status,
        listener: (context, state) {
          if (state.status == Status.success) {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil('/', (route) => false);
          } else if (state.status == Status.failure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('Failed to add task')));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add Task',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontWeight: FontWeight.w800,
              ),
            ),
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.whiteColor,
          ),
          backgroundColor: AppColors.whiteColor,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'What task do you want to add?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _controller,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 18,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter your task here',
                    hintStyle: TextStyle(color: AppColors.boxShadowColor),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        width: 2,
                        color: AppColors.boxShadowColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
                BlocBuilder<AddTaskCubit, AddTaskState>(
                  builder: (context, state) {
                    return AddButton(
                      isLoading: state.status == Status.loading,
                      onPressed: () {
                        final messenger = ScaffoldMessenger.of(context);
                        if (_controller.text.trim().isEmpty) {
                          messenger.clearSnackBars();
                          messenger.showSnackBar(
                            const SnackBar(
                              backgroundColor: AppColors.primaryColor,
                              content: Text('Please enter a task description'),
                            ),
                          );
                          return;
                        } else {
                          context.read<AddTaskCubit>().addTask(
                            _controller.text,
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
