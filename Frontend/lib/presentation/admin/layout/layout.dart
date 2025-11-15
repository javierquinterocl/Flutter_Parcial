import 'package:cuenta/config/router/router_admin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Layout extends StatelessWidget {
  final Widget child;
  const Layout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Productos')),
      body: child,
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
                      // VERIFICA SI LA RUTA ES LA MISMA  
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
