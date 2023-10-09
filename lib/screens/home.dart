import 'package:flutter/material.dart';
import '../models/todo_items_list.dart';
import '../widgets/todo_items.dart';

class MyHome extends StatefulWidget {
  MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final todosList = TodoModel.todoList();

  final _addToDoController = TextEditingController();
  String _search = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 229, 229, 229),
        appBar: appBar_build(),
        body: Column(
          children: [
            searchBar(),
            Expanded(
              child: Stack(
                children: [
                  ListView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 20),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'All ToDos',
                            style: TextStyle(
                                fontSize: 50, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      for (TodoModel todoo in todosList.reversed)
                        if (todoo.text
                            .toLowerCase()
                            .contains(_search.toLowerCase()))
                          ToDo(
                            todo: todoo,
                            onDelete: _deleteTodoItem,
                            onTodoChanged: _handleTodoChange,
                          ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: TextField(
                            controller: _addToDoController,
                            decoration: InputDecoration(
                                hintText: 'Add a new todo item',
                                suffixIcon: IconButton(
                                    onPressed: () =>
                                        _addTodoItem(_addToDoController.text),
                                    icon: Icon(Icons.add)),
                                suffixIconColor: Colors.blue,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ),
                      )),
                    ]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleTodoChange(TodoModel todo) {
    setState(() {
      todo.isDOne = !todo.isDOne;
    });
  }

  void _deleteTodoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
    });
  }

  void _addTodoItem(String todo) {
    if (!_addToDoController.text.isEmpty) {
      setState(() {
        todosList.add(TodoModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            text: todo,
            isDOne: false));
      });
    }

    _addToDoController.clear();
    FocusScope.of(context).unfocus();
  }

  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: TextField(
          onChanged: (value) {
            setState(() {
              _search = value;
            });
          },
          decoration: InputDecoration(
              // contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: Colors.grey),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, minWidth: 25)),
        ),
      ),
    );
  }

  AppBar appBar_build() {
    return AppBar(
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
    );
  }
}
