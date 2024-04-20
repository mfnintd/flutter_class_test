import 'package:flutter/material.dart';
import 'package:for_flutter_class/add_task.dart';
import 'package:for_flutter_class/task.dart';

void main() {
  runApp(MaterialApp(home: MainApp()));
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  final listTask = [
    Task(
      title: 'He heheeh hehehe ',
      deadline: DateTime(2024),
      startTime: const TimeOfDay(hour: 12, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      remind: 'remind',
      repeat: 'repeat',
      color: Colors.green,
      isCompleted: false,
      isFavorite: false,
    ),
    Task(
      title: 'He heheeh hehehe ',
      deadline: DateTime(2024),
      startTime: const TimeOfDay(hour: 12, minute: 0),
      endTime: const TimeOfDay(hour: 12, minute: 0),
      remind: 'remind',
      repeat: 'repeat',
      color: Colors.purple,
      isCompleted: false,
      isFavorite: false,
    ),
  ];

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    List<Task> uncompletedList = widget.listTask.where((element) => element.isCompleted == false).toList();
    List<Task> completedList = widget.listTask.where((element) => element.isCompleted == true).toList();
    List<Task> favoriteList = widget.listTask.where((element) => element.isFavorite == true).toList();
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add a Task'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTask(),
                  ),
                );
              },
            ),
          ),
          appBar: AppBar(
            title: const Text('Board'),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_month)),
            ],
            bottom: const TabBar(
              //isScrollable: true,
              //padding: EdgeInsets.all(0),
              tabAlignment: TabAlignment.center,
              tabs: [
                Tab(child: Text('All')),
                Tab(child: Text('Uncompleted')),
                Tab(child: Text('Completed')),
                Tab(child: Text('Favorite')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemBuilder: (context, index) => _buildTask(widget.listTask[index]),
                itemCount: widget.listTask.length,
              ),
              ListView.builder(
                itemBuilder: (context, index) => _buildTask(uncompletedList[index]),
                itemCount: uncompletedList.length,
              ),
              ListView.builder(
                itemBuilder: (context, index) => _buildTask(completedList[index]),
                itemCount: completedList.length,
              ),
              ListView.builder(
                itemBuilder: (context, index) => _buildTask(favoriteList[index]),
                itemCount: favoriteList.length,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTask(Task task) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: task.color, borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Checkbox(
            //tristate: ,
            value: task.isCompleted,
            onChanged: (value) {
              task.isCompleted = value!;
              setState(() {});
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'From ${task.startTime} - To ${task.endTime}',
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Deadline: ${task.deadline}',
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                task.isFavorite = !task.isFavorite;
              });
            },
            icon: task.isFavorite
                ? const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                : const Icon(Icons.favorite_border),
          ),
        ],
      ),
    );
  }
}
