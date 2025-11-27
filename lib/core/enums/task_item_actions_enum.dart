enum TaskItemActionsEnum {
  markerAsDone(name: 'Done | Not Done'),
  edit(name: 'Edit'),
  delete(name: 'Delete');

  final String name;

  const TaskItemActionsEnum({required this.name});
}
