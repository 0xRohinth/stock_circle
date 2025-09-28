import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _category = '';
  String _unit = '';
  double _b2bPrice = 0;
  double _b2cPrice = 0;
  int _stockQty = 0;
  String? _notes;

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newProduct = Product(
        name: _name,
        category: _category,
        unit: _unit,
        b2bPrice: _b2bPrice,
        baseB2cPrice: _b2cPrice,
        stockQty: _stockQty,
        notes: _notes,
      );

      Provider.of<ProductProvider>(context, listen: false).addProduct(newProduct);

      Navigator.pop(context); // go back to list
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Product Name"),
                  validator: (val) => val!.isEmpty ? "Enter name" : null,
                  onSaved: (val) => _name = val!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Category"),
                  onSaved: (val) => _category = val ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Unit (e.g., kg, pcs)"),
                  onSaved: (val) => _unit = val ?? '',
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "B2B Price"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _b2bPrice = double.tryParse(val!) ?? 0,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Base B2C Price"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _b2cPrice = double.tryParse(val!) ?? 0,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Stock Quantity"),
                  keyboardType: TextInputType.number,
                  onSaved: (val) => _stockQty = int.tryParse(val!) ?? 0,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "Notes"),
                  onSaved: (val) => _notes = val,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _saveForm,
                  child: const Text("Save Product"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
