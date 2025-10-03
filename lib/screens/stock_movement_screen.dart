import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class StockMovementScreen extends StatefulWidget {
  final String type; // "in" or "out"

  const StockMovementScreen({super.key, required this.type});

  @override
  State<StockMovementScreen> createState() => _StockMovementScreenState();
}

class _StockMovementScreenState extends State<StockMovementScreen> {
  final _formKey = GlobalKey<FormState>();
  Product? _selectedProduct;
  final _quantityController = TextEditingController();
  final _noteController = TextEditingController();

  String get _title =>
      widget.type == "in" ? "Stock In (Purchase)" : "Stock Out (Sale/Usage)";

  
Future<void> _saveMovement() async {
  if (_formKey.currentState!.validate() && _selectedProduct != null) {
    final quantity = int.parse(_quantityController.text);

    // For Stock Out, check stock
    if (widget.type == "out" && quantity > _selectedProduct!.stockQty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Not enough stock available!")),
      );
      return;
    }

    // Use provider to add movement and update stock
    await Provider.of<ProductProvider>(context, listen: false)
        .addStockMovement(_selectedProduct!.id!, quantity, widget.type,
            note: _noteController.text);

    Navigator.pop(context); // go back after updating
  }
}


  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductProvider>(context).products;

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonFormField<Product>(
                decoration: const InputDecoration(labelText: "Select Product"),
                initialValue: _selectedProduct,
                items: products.map((p) {
                  return DropdownMenuItem(
                    value: p,
                    child: Text(p.name),
                  );
                }).toList(),
                onChanged: (p) => setState(() => _selectedProduct = p),
                validator: (value) =>
                    value == null ? "Please select a product" : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: "Quantity"),
                keyboardType: TextInputType.number,
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter quantity" : null,
              ),
              TextFormField(
                controller: _noteController,
                decoration: const InputDecoration(labelText: "Note (optional)"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveMovement,
                child: Text(widget.type == "in" ? "Add Stock In" : "Add Stock Out"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
