import 'package:cuenta/services/admin/producto/producto_service.dart';
import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _imageController = TextEditingController();
  List<String> _images = [];
  bool _loading = false;

  void _addImage() {
    if (_imageController.text.isNotEmpty) {
      setState(() {
        _images.add(_imageController.text);
        _imageController.clear();
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _saveProducto(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Por favor completa todos los campos')));
      return;
    }

    setState(() {
      _loading = true;
    });

    final price = int.tryParse(_priceController.text) ?? 0;
    String data = await ProductoService.saveProducto(
      _titleController.text,
      price,
      _descriptionController.text,
      _images.isEmpty ? ['https://placehold.co/600x400'] : _images,
      _categoryController.text,
    );
    
    if (!mounted) return;
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data)));
    
    if (data.contains('correctamente')) {
      _titleController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _categoryController.clear();
      _images.clear();
    }
    
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Registro de Productos',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Título',
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'El título es requerido'
                    : null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Precio',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'El precio es requerido';
                }
                if (int.tryParse(value) == null) {
                  return 'Ingresa un precio válido';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 3,
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'La descripción es requerida'
                    : null;
              },
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Categoría',
                prefixIcon: Icon(Icons.category),
              ),
              validator: (value) {
                return value == null || value.isEmpty
                    ? 'La categoría es requerida'
                    : null;
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _imageController,
                    decoration: InputDecoration(
                      labelText: 'URL de imagen',
                      prefixIcon: Icon(Icons.image),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addImage,
                ),
              ],
            ),
            if (_images.isNotEmpty) ...[
              SizedBox(height: 8),
              ...List.generate(_images.length, (index) {
                return ListTile(
                  title: Text(_images[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeImage(index),
                  ),
                );
              }),
            ],
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _loading ? null : () => _saveProducto(context),
                icon: _loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save),
                label: Text(_loading ? 'Guardando...' : 'Guardar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    super.dispose();
  }
}

