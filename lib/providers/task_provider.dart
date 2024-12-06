import 'package:flutter/material.dart';
import 'package:repaso_final/models/task.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskProvider with ChangeNotifier{

  List<Task> _listTasks = [];
  List<Task> get listTasks => _listTasks;

  Future<void> fetchTasks() async{
    final response = await http.get(Uri.parse("https://67180fecb910c6a6e02afe14.mockapi.io/tasks"));
    if(response.statusCode == 200){
      final List<dynamic> data = json.decode(response.body);
      _listTasks = data.map((task) => Task.fromJson(task)).toList();
      notifyListeners();
    }else{
      throw Exception("Error al cargar usuarios");
    }
  }

  // void addTask(Task task){
  //   _listTasks.add(task);
  //   notifyListeners();
  // }

  Future<void> addTask(Task task) async{
    final response = await http.post(
      Uri.parse("https://67180fecb910c6a6e02afe14.mockapi.io/tasks"),
      headers: {'Content-type': 'application/json'},
      body: json.encode(task.toJson())
    );
    if(response.statusCode == 201){
      final newTask = Task.fromJson(json.decode(response.body));
      _listTasks.add(newTask);
      notifyListeners();
    }else{
      throw Exception("Error al agregar tarea");
    }
  }

  // void updateTask(String id, Task task){
  //   int index = _listTasks.indexWhere((task)=> task.id == id);
  //   if(index != -1){
  //     _listTasks[index] = task;
  //     notifyListeners();
  //   }
  // }

  Future<void> updateTask(String id, Task task) async {
    final response = await http.put(
      Uri.parse("https://67180fecb910c6a6e02afe14.mockapi.io/tasks/$id"),
      headers: {'Content-type': 'application/json'},
      body: json.encode(task.toJson())
    );
    if(response.statusCode == 200){
      int index = _listTasks.indexWhere((t) => t.id == id);
      if(index != -1){
        _listTasks[index] = Task.fromJson(json.decode(response.body));
        notifyListeners();
      }else{
        throw Exception("Error al actualizar usuario");
      }
    }
  }

  // void deleteTask(String id){
  //   _listTasks.removeWhere((task)=> task.id == id);
  //   notifyListeners();
  // }

  Future<void> deleteTask(String id) async{
    final response = await http.delete(
      Uri.parse("https://67180fecb910c6a6e02afe14.mockapi.io/tasks/$id"),
    );
    if(response.statusCode == 200){
      _listTasks.removeWhere((task)=> task.id == id);
      notifyListeners();
    }else{
      throw Exception("Error al eliminar tarea");
    }
  }

}