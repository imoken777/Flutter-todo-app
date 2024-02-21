class TodoItem {
  TodoItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });

  final String id;
  final String title;
  bool isCompleted;
}
