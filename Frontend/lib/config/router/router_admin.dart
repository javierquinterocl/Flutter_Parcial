import 'package:cuenta/config/router/router_model.dart';
import 'package:cuenta/presentation/admin/screen_admin.dart';
import 'package:flutter/material.dart';

final routerConfigAdmin = <RouterModel>[
  RouterModel(
    name: 'adminProducto',
    screen: (context, state) => const ProductoScreen(),
    title: 'Producto',
    patch: '/admin/producto',
    icon: Icons.inventory_2,
    description: '',
  ),
];
