import 'package:cuenta/config/router/router_admin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parcial Home"),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              "Bienvenido a la pantalla de inicio",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              "Presentado por: \n"
              "Javier Quintero 192163 \n"
              "Juan Jose Garcia Torres 192102",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ...routerConfigAdmin
                .where((s) => s.inDrawer)
                .map(
                  (screen) => ListTile(
                    leading: Icon(screen.icon),
                    title: Text(screen.title),
                    onTap: () {
                      Navigator.pop(context); // Cierra el drawer
                      //  VERIFICA SI LA RUTA ES LA MISMA  
                      final currentLocation = GoRouterState.of(context).uri.path;
                      if (currentLocation != screen.patch) {
                        context.go(screen.patch);
                      }
                    },
                  ),
                )
          ],
        ),
      ),
    );
  }
}
