import 'package:cuenta/config/router/router_model.dart';
import 'package:cuenta/presentation/admin/screen_admin.dart';
import 'package:flutter/material.dart';
import 'package:cuenta/presentation/public/auth/auth_screen.dart';

final routerConfigAdmin = <RouterModel>[
  RouterModel(
    name: 'home',
    screen: (context, state) => const AuthScreen(),
    title: 'Inicio',
    patch: '/',
    icon: Icons.home,
    description: '',
    inDrawer: true,
  ),
  RouterModel(
    name: 'adminProducto',
    screen: (context, state) => const ProductoScreen(),
    title: 'Producto',
    patch: '/admin/producto',
    icon: Icons.inventory_2,
    description: '',
    inDrawer: true, 
  ),
];

