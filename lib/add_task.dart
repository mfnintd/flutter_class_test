import 'package:flutter/material.dart';

import 'task.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _deadlineController = TextEditingController();

  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();

  String remindValue = '10 mins early';

  /// color selected
  Color selectedColor = colorItems[0];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _keyform,
        child: Scaffold(
          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Create a Task'),
              onPressed: () {
                //
                if (_keyform.currentState!.validate()) {
                  //ScaffoldMessenger.of(context)
                  Navigator.pop(context);
                }
              },
            ),
          ),
          appBar: AppBar(
              //automaticallyImplyLeading: true,
              ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Title'),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[150],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter text';
                      }

                      return null;
                    },
                  ),
                  const Text('Deadline'),
                  TextFormField(
                    controller: _deadlineController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[150],
                      suffixIcon: const Icon(Icons.calendar_month),
                    ),
                    onTap: () async {
                      DateTime? newDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (newDate == null) return;
                      _deadlineController.text = newDate.toString();
                    },
                    //enabled: false,
                    readOnly: true,
                  ),
                  const Text('Remind'),
                  DropdownButtonFormField(
                    //validator: ,
                    value: remindValue,
                    items: <String>[
                      '10 mins early',
                      '20 mins early',
                      '30 mins early',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[150],
                    ),
                  ),

                  /// Select color here
                  const Text(
                    'Color',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        for (Color color in colorItems) _colorSelectButton(color),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _colorSelectButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        height: 40,
        width: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: color == selectedColor ? Colors.black : Colors.transparent,
            width: 4,
          ),
        ),
        child: Icon(
          Icons.check,
          color: color == selectedColor ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }
}
