import 'package:cuenta/model/admin/producto_model.dart';
import 'package:dio/dio.dart';

class ProductoService {
  static final _dio = Dio();
  static final url = 'http://localhost:8080/product';

  static Future<String> saveProducto(
    String title,
    int price,
    String description,
    List<String> images,
    String category,
  ) async {
    try {
      final response = await _dio.post(
        url,
        data: {
          "title": title,
          "price": price,
          "description": description,
          "images": images,
          "category": category,
        },
      );
      if (response.statusCode != 201 && response.statusCode != 200) {
        return 'Respuesta inesperada del servidor.';
      }
      return 'Producto ingresado correctamente';
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 400) {
          return e.response?.data['message'] ?? 'Error al crear el producto';
        }
        return 'Error del servidor: ${e.response?.statusCode}';
      } else {
        return 'Error de red. Revisa tu conexión a internet.';
      }
    }
  }

  static Future<List<ProductoModel>> getProductos() async {
    try {
      final response = await _dio.get(url);
      List<ProductoModel> productos = [];
      if (response.statusCode != 200) {
        return [];
      }
      for (final item in response.data) {
        productos.add(ProductoModel.fromJson(item));
      }
      return productos;
    } on DioException catch (e) {
      print('Error al obtener productos: $e');
      return [];
    }
  }


}

