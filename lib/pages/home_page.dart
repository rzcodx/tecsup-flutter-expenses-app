import 'package:expenses_app/database/db_helper_products.dart';
import 'package:expenses_app/models/product_model.dart';
import 'package:expenses_app/widgets/register_modal_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DbHelperProducts _db = DbHelperProducts();
  List<ProductModel> _products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _db.listProducts().then((rows) {
      setState(() {
        _products = rows.map(ProductModel.fromMap).toList();
      });
    });
  }

  Future<void> showRegisterModal() async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        return RegisterModalWidget();
      },
    );
    if (saved == true) {
      _loadProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Resumen de gastos",
            style: TextStyle(fontSize: 22, fontWeight: .bold),
          ),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: .end,
              children: [
                GestureDetector(
                  onTap: () {
                    showRegisterModal();
                  },
                  child: Container(
                    color: Colors.black,
                    width: double.infinity,
                    height: 110,
                    child: Row(
                      mainAxisAlignment: .center,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          "Agregar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Aplicativo de gastos",
                          style: TextStyle(fontSize: 22, fontWeight: .bold),
                        ),
                        Text("Bienvenido"),
                        Text(
                          "Gestiona tus gastos de la mejor forma",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              final product = _products[index];
                              return Card(
                                child: ListTile(
                                  title: Text(
                                    product.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(product.date),
                                  trailing: Text(
                                    "S/ ${product.price.toStringAsFixed(2)}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  leading: Image.asset(
                                    "assets/icons/${product.type}.webp",
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 90),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
