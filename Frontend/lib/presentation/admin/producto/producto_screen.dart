import 'package:cuenta/presentation/admin/producto/consult_screen.dart';
import 'package:cuenta/presentation/admin/producto/form_screen.dart';
import 'package:flutter/material.dart';

class ProductoScreen extends StatefulWidget {
  const ProductoScreen({super.key});

  @override
  State<ProductoScreen> createState() => _ProductoScreenState();
}

class _ProductoScreenState extends State<ProductoScreen> {
  int index = 0;
  final List<Widget> _screens = [FormScreen(), ConsultScreen()];

  void _onItemTapped(int index) {
    setState(() {
      this.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens[index],

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Agregar'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Consultar'),
          ],
          currentIndex: index,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

