// import 'package:datarunmobile/tree_examples/stacked/stacked_try.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
//
// class TodosScreenViewModel extends ReactiveViewModel {
//   final _firstTodoFocusNode = FocusNode();
//   final _todosService = appLocator<TodosService>();
//   late final toggleStatus = _todosService.toggleStatus;
//   late final removeTodo = _todosService.removeTodo;
//   late final updateTodoContent = _todosService.updateTodoContent;
//
//   List<Todo> get todos => _todosService.todos;
//
//   void newTodo() {
//     _todosService.newTodo();
//     _firstTodoFocusNode.requestFocus();
//   }
//
//   FocusNode? getFocusNode(String id) {
//     final index = todos.indexWhere((todo) => todo.id == id);
//     return index == 0 ? _firstTodoFocusNode : null;
//   }
//
//   @override
//   List<ReactiveServiceMixin> get reactiveServices => [_todosService];
// }
