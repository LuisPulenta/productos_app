import 'package:flutter/material.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsServices = Provider.of<ProductsService>(context);

    if (productsServices.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(title: Text('Productos')),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ProductCard(
            product: productsServices.products[index],
          ),
          onTap: () {
            productsServices.selectedProduct =
                productsServices.products[index].copy();
            Navigator.pushNamed(context, 'product');
          },
        ),
        itemCount: productsServices.products.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
