import 'package:flutter/material.dart';
import 'package:repaso_final/screens/components/list_tasks.dart';
import 'package:repaso_final/screens/components/profile.dart';

class Navbar extends StatefulWidget {
  const Navbar({ Key? key }) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  int _selectedIndex = 0;

  List<Widget> _pages = <Widget>[
    ListTasks(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lista de Usuarios", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey.shade900,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index){
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lista de Tareas"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Perfil"),
        ],
      ),
    );
  }
}