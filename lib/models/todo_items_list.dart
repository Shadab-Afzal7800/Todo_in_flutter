class TodoModel {
  String id;
  String text;
  bool isDOne;
  TodoModel({required this.id, required this.text, required this.isDOne});
  static List<TodoModel> todoList() {
    return [
      TodoModel(id: '01', text: 'Morning Exercise', isDOne: false),
      TodoModel(id: '02', text: 'Buy Groceries', isDOne: false),
      TodoModel(id: '03', text: 'Check Emails', isDOne: false),
      TodoModel(id: '04', text: 'Go to gym', isDOne: false),
      TodoModel(id: '05', text: 'Take a night walk', isDOne: false),
    ];
  }
}
