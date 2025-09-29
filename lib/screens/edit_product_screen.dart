import 'package:flutter/material.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _unitController;
  late TextEditingController _purchasePriceController;
  late TextEditingController _basePriceController;
  late TextEditingController _stockController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _categoryController = TextEditingController(text: widget.product.category);
    _unitController = TextEditingController(text: widget.product.unit);
    _purchasePriceController = TextEditingController(text: widget.product.b2bPrice.toString());
    _basePriceController = TextEditingController(text: widget.product.baseB2cPrice.toString());
    _stockController = TextEditingController(text: widget.product.stockQty.toString());
    _notesController = TextEditingController(text: widget.product.notes);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _unitController.dispose();
    _purchasePriceController.dispose();
    _basePriceController.dispose();
    _stockController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveProduct() {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = Product(
        id: widget.product.id, // important
        name: _nameController.text,
        category: _categoryController.text,
        unit: _unitController.text,
        b2bPrice: double.parse(_purchasePriceController.text),
        baseB2cPrice: double.parse(_basePriceController.text),
        stockQty: int.parse(_stockController.text),
        notes: _notesController.text,
      );

      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(updatedProduct);

      Navigator.pop(context); // go back after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Edit Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(controller: _nameController, decoration: const InputDecoration(labelText: "Product Name")),
              TextFormField(controller: _categoryController, decoration: const InputDecoration(labelText: "Category")),
              TextFormField(controller: _unitController, decoration: const InputDecoration(labelText: "Unit")),
              TextFormField(controller: _purchasePriceController, decoration: const InputDecoration(labelText: "Purchase Price"), keyboardType: TextInputType.number),
              TextFormField(controller: _basePriceController, decoration: const InputDecoration(labelText: "Base B2C Price"), keyboardType: TextInputType.number),
              TextFormField(controller: _stockController, decoration: const InputDecoration(labelText: "Stock Quantity"), keyboardType: TextInputType.number),
              TextFormField(controller: _notesController, decoration: const InputDecoration(labelText: "Notes")),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: const Text("Save Changes"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
