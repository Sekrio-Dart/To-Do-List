import 'package:flutter/material.dart';
//import material.dart for material design widgets

void main() => runApp(const ToDoApp());
//we use => fat arrow when it's a single statement, and {} for multiple lines

class ToDoApp
    extends
        StatelessWidget //extends: is type of
        {
  const ToDoApp({super.key});
  //const to construct the class
  //super.key is for passing the key to the parent class StatelessWidget
  //keys help identify toDoApp in the widget tree to avoid rebuilding widgets that didn't change

  @override
  //replacing a method from parent class with your own version
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //it tells the app to not show the debug banner on the screen
      title: 'To-Do App',
      theme: ThemeData(primarySwatch: Colors.blue),
      //theme = choosing the app's outfit, themedate is where you pick colors, fonts, and styles. primary swatch = choosing the color
      home: ToDoHome(),
      //todohome is the first page the app would show
      //BuildContest context is like the location of this widget in the widget tree
      //MaterialApp takes a widget and tells screen how it would look
    );
  }
}

class ToDoHome extends StatefulWidget
//class ToDoHome is a stateful widget
{
  const ToDoHome({super.key});

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
  //ToDoHome will have a state object that controls it's changing parts
  //state is anything in the widget that can be changed over time
  //statefulwidget has a method called createState() that you must implement
  //ToDoHome (StatefulWidget)  = robot body
  //_ToDoHomeState (State)     = robot brain
  //createState()              = connecting the brain to the body
}

class _ToDoHomeState extends State<ToDoHome> {
  final List<String> _tasks = [];
  //creates a List of type String names _tasks
  final TextEditingController _controller = TextEditingController();
  //final: this variable won't point to any different object later
  //TextEditingController stores and keeps track of what the user writes
  //TextEditingController() creates a controller object so text fields remeber what's typed or let you change it

  void _addTask() {
    if (_controller.text.isEmpty) return;
    setState(() {
      _tasks.add(_controller.text);
      _controller.clear();
    });
    //if _controller textfield is empty then return, else add the text into the list _tasks then empty the textfield
  }

  void _removeTask(int index) {
    setState(() => _tasks.removeAt(index));
  }
  //setState = if something changed it notifies flutter to redraw the screen
  //removeTask method takes an index variable and goes to _tasks list to delete the item from ToDo List

  @override
  Widget build(BuildContext context) {
    // it tells Flutter what the UI should look like every time something changes
    return Scaffold(
      // Scaffold = the basic page layout
      appBar: AppBar(title: const Text('My To-Do List')),
      // AppBar = the top bar with the title
      body: Column(
        // Column = stack widgets vertically
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // add space around the row
            child: Row(
              // Row = put widgets horizontally
              children: [
                Expanded(
                  // Expanded = make this widget fill the remaining space
                  child: TextField(
                    // TextField = box where user types a new task
                    controller: _controller,
                    // _controller = keeps track of what user types
                    decoration: const InputDecoration(
                      // decoration = make the TextField look nicer
                      hintText: 'Enter a new task',
                      // hintText = faded text that tells user what to type
                      border: OutlineInputBorder(),
                      // adds a border around the TextField
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // SizedBox = add some horizontal space between TextField and button
                ElevatedButton(
                  // button to add a new task
                  onPressed: _addTask,
                  // call _addTask() when button is pressed
                  child: const Text('Add'),
                  // text on the button
                ),
              ],
            ),
          ),
          Expanded(
            // Expanded = make the list take up all remaining vertical space
            child: ListView.builder(
              // ListView.builder = create a scrollable list dynamically
              itemCount: _tasks.length,
              // number of items = length of the task list
              itemBuilder: (context, index) => Card(
                // Card = a little rectangle with shadow for each task
                child: ListTile(
                  // ListTile = standard row layout with title and optional trailing widget
                  title: Text(_tasks[index]),
                  // show the task text
                  trailing: IconButton(
                    // a button at the end of the row
                    icon: const Icon(Icons.delete, color: Colors.red),
                    // trash icon, colored red
                    onPressed: () => _removeTask(index),
                    // call _removeTask() to delete this task
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
