import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:stock_circle/models/product.dart';
import 'package:stock_circle/screens/edit_product_screen.dart';
import '../providers/product_provider.dart';
//import '../models/product.dart';
import 'add_product_screen.dart';
import 'stock_movement_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<void> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = Provider.of<ProductProvider>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      body: FutureBuilder(
        future: _productsFuture,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (productProvider.products.isEmpty) {
            return const Center(child: Text("No products yet. Add some!"));
          }
          return ListView.builder(
            itemCount: productProvider.products.length,
            itemBuilder: (ctx, i) {
              final p = productProvider.products[i];
              return Card(
                child: ListTile(
                  title: Text(p.name),
                  subtitle: Text(
                    "Stock: ${p.stockQty}, B2B: ₹${p.b2bPrice}, B2C: ₹${p.baseB2cPrice}",
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProductScreen(product: p),
                      ),
                    );
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      productProvider.deleteProduct(p.id!);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "addProduct",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (ctx) => const AddProductScreen()),
              );
            },
            child: const Icon(Icons.add),
            tooltip: "Add Product",
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "stockIn",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const StockMovementScreen(type: "in"),
                ),
              );
            },
            child: const Icon(Icons.arrow_downward),
            tooltip: "Stock In",
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "stockOut",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const StockMovementScreen(type: "out"),
                ),
              );
            },
            child: const Icon(Icons.arrow_upward),
            tooltip: "Stock Out",
          ),
        ],
      ),
    );
  }
}
