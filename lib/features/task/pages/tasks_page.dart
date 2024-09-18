import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/tasks_store.dart';
import 'package:todo_list_project/features/task/models/index.dart';
import '../../../shared/themes/index.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  _showTaskAlert(BuildContext context, TaskStore store) {
    String taskName = '';
    String description = '';

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add new task'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                        labelText: "what's the task name?"),
                    onChanged: (value) {
                      taskName = value;
                    },
                  ),
                  TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                        labelText: "what's the description?"),
                    onChanged: (value) {
                      description = value;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (taskName.isNotEmpty) {
                        store.addTask(taskName, description);
                        Navigator.pop(context);
                      }
                    },
                    child: const Icon(Icons.check),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showTaskModal(BuildContext context, Task task, TaskStore store) {
    Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.taskName, 
            style: const TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 20),
          Text(task.description),
          Visibility(
            visible: task.description.isEmpty, 
            child: const SizedBox(
              height: 40,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, 
          children: [
              ElevatedButton(
                onPressed: () {
                store.deleteTask(task.id);
                Navigator.pop(context);
                },
                child: const Icon(Icons.delete),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder : (context) {
                      TextEditingController titleController = TextEditingController(text: task.description);
                      TextEditingController descriptionController = TextEditingController(text: task.description);
                      return AlertDialog(
                        title: const Text("Editing Task..."),
                        content: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                controller: titleController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  labelText: 'New Title',
                                ),
                                onSubmitted: (value) {
                                  titleController.text = value;
                                },
                              ),
                              const SizedBox(height: 12,),
                              TextField(
                                controller: descriptionController,
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  labelText: 'New Descrition',
                                ),
                                onSubmitted: (value) {
                                  descriptionController.text = value;
                                },
                              ),
                              const SizedBox(height: 8,),
                              ElevatedButton(
                                onPressed: () {
                                  store.updateTask(task.id, task.taskName, task.description);
                                },
                                child: const Icon(Icons.check)
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  Navigator.pop(context);
                },
                child: const Icon(Icons.edit),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _showListViewStatus(List<Task> tasks, String label, TaskStore store) {
    return Expanded(
        child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.outline),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.outline),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task.taskName,
                    style: TextStyle(
                        decoration: task.isDone == 1
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: task.isDone == 0 
                            ? Colors.black 
                            : Colors.grey
                            ),
                  ),
                  leading: Checkbox(value: task.isDone == 1, onChanged: (bool? isDone) => store.updateTaskStatus(task.id, isDone == true ? 1 :0)),
                  onLongPress: () {
                    showModalBottomSheet(context: context, builder: (BuildContext context) => _showTaskModal(context, task, store));
                  },
                );
              },
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final taskStore = Provider.of<TaskStore>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.greenSofTec,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Task List"),
        elevation: 10,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
        child: FutureBuilder(
            future: taskStore.loadTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final tasks = taskStore.tasks;

              final pendingTasks =
                  tasks.where((task) => task.isDone == 0).toList();
              final doneTasks =
                  tasks.where((task) => task.isDone == 1).toList();

              return Column(
                children: [
                  _showListViewStatus(pendingTasks, 'Pending', taskStore),
                  const SizedBox(
                    height: 8,
                  ),
                  _showListViewStatus(doneTasks, 'Finished', taskStore),
                ],
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showTaskAlert(context, taskStore);
        },
        backgroundColor: MyColors.greenSofTec,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        icon: const Icon(Icons.task_alt),
        label: const Text(
          "Add Task",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
