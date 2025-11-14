import 'package:cuenta/model/admin/producto_model.dart';
import 'package:cuenta/services/admin/producto/producto_service.dart';
import 'package:flutter/material.dart';

class ConsultScreen extends StatefulWidget {
  const ConsultScreen({super.key});

  @override
  State<ConsultScreen> createState() => _ConsultScreenState();
}

class _ConsultScreenState extends State<ConsultScreen> {
  bool loading = true;
  List<ProductoModel> productos = [];

  void getProductos() async {
    final tempProductos = await ProductoService.getProductos();
    setState(() {
      productos = tempProductos;
      loading = false;
    });
  }


  @override
  void initState() {
    super.initState();
    getProductos();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Center(child: CircularProgressIndicator());
    }

    if (productos.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No hay productos registrados'),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          loading = true;
        });
        getProductos();
      },
      child: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: producto.images.isNotEmpty
                  ? Image.network(
                      producto.images.first,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.image, size: 50);
                      },
                    )
                  : Icon(Icons.image, size: 50),
              title: Text(producto.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(producto.description),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '\$${producto.price}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text(
                        producto.category,
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

