import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repaso_final/models/task.dart';
import 'package:repaso_final/providers/task_provider.dart';

class ListTasks extends StatefulWidget {
  const ListTasks({ Key? key }) : super(key: key);

  @override
  _ListTasksState createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });
  }

  TextEditingController _title = TextEditingController();
  TextEditingController _description = TextEditingController();

  TextEditingController _updateTitle = TextEditingController();
  TextEditingController _updateDescription = TextEditingController();

  void _getTask(Task task){
    _updateTitle.text = task.title;
    _updateDescription.text = task.description;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, child){
                return ListView.builder(
                  itemCount: taskProvider.listTasks.length,
                  itemBuilder: (context, index){
                    Task task = taskProvider.listTasks[index];
                    return ListTile(
                      title: Text(task.title),
                      subtitle: Text(task.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: (){
                              _getTask(task);
                              showDialog(
                                context: context, 
                                builder: (context){
                                  return AlertDialog(
                                    title: Text("Actualizar Tarea"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _updateTitle,
                                          decoration: InputDecoration(label: Text("Titulo")),
                                        ),
                                        TextField(
                                          controller: _updateDescription,
                                          decoration: InputDecoration(label: Text("Descripcion")),
                                        )
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: (){
                                          Provider.of<TaskProvider>(context, listen: false).updateTask(
                                            task.id.toString(), 
                                            Task(
                                              id: task.id, 
                                              title: _updateTitle.text, 
                                              description: _updateDescription.text
                                            )
                                          );
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Tarea actualizada"))
                                          );
                                          Navigator.pop(context);
                                        }, 
                                        child: Text("Actualizar Tarea")
                                      ),
                                      TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        }, 
                                        child: Text("Cancelar")
                                      )
                                    ],
                                  );
                                }
                              );
                            }, 
                            icon: Icon(Icons.edit)
                          ),
                          IconButton(
                            onPressed: (){
                              Provider.of<TaskProvider>(context, listen: false).deleteTask(task.id.toString());
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Tarea eliminada"))
                              );
                            }, 
                            icon: Icon(Icons.delete)
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: (){
          showDialog(
            context: context, 
            builder: (context){
              return AlertDialog(
                title: Text("Agregar Tarea"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _title,
                      decoration: InputDecoration(label: Text("Titulo")),
                    ),
                    TextField(
                      controller: _description,
                      decoration: InputDecoration(label: Text("Descripcion")),
                    )
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: (){
                      Provider.of<TaskProvider>(context, listen: false).addTask(
                        Task(title: _title.text, description: _description.text)
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Tarea agregada"))
                      );
                    }, 
                    child: Text("Agregar tarea")
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.pop(context);
                    }, 
                    child: Text("Cancelar")
                  )
                ],
              );
            }
          );
        }
      ),
    );
  }
}