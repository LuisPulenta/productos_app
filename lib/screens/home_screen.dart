import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/screens/screens.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsServices = Provider.of<ProductsService>(context);
    final authServices = Provider.of<AuthService>(context, listen: false);

    if (productsServices.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        leading: IconButton(
          icon: const Icon(Icons.login_outlined),
          onPressed: () {
            authServices.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
      ),
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
        child: const Icon(Icons.add),
        onPressed: () {
          productsServices.selectedProduct =
              Product(available: true, name: '', price: 0.0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
