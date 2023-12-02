import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List with User Profile',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Task> tasks = [
    Task(description: 'Problem'),
    Task(description: 'Solution'),
    Task(description: 'Conclusion'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserProfile(
            imagePath:
                'assets/limon.jpg', // Replace with the path to your profile image
            userName: 'Monayem Hossain limon',
            userEmail: 'limonhossain82.com',
            userLocation: 'Dhaka, Bangladesh',
            tasksAmount: tasks.length,
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Tasks:',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: TaskList(tasks: tasks, onTaskToggle: onTaskToggle),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';
        return AlertDialog(
          title: const Text('Add a New Task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter the task',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(description: newTask));
                });
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void onTaskToggle(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }
}

class UserProfile extends StatelessWidget {
  final String imagePath;
  final String userName;
  final String userEmail;
  final String userLocation;
  final int tasksAmount;

  UserProfile({
    required this.imagePath,
    required this.userName,
    required this.userEmail,
    required this.userLocation,
    required this.tasksAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100.0,
            height: 100.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            userName,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          Text(
            userEmail,
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
          Text(
            userLocation,
            style: TextStyle(fontSize: 16.0, color: Colors.grey),
          ),
          SizedBox(height: 8.0),
          Text(
            'Total Tasks: $tasksAmount',
            style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Color(0xff308674)),
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  final List<Task> tasks;
  final Function(int) onTaskToggle;

  TaskList({required this.tasks, required this.onTaskToggle});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return TaskItem(
          task: widget.tasks[index],
          onTaskToggle: () {
            widget.onTaskToggle(index);
          },
        );
      },
    );
  }
}

class Task {
  String description;
  bool isCompleted;

  Task({required this.description, this.isCompleted = false});
}

class TaskItem extends StatelessWidget {
  final Task task;
  final VoidCallback onTaskToggle;

  TaskItem({required this.task, required this.onTaskToggle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.description,
        style: task.isCompleted
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (value) {
          onTaskToggle();
        },
      ),
    );
  }
}
