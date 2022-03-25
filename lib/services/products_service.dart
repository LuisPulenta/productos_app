import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-89b3a-default-rtdb.firebaseio.com';
  final List<Product> products = [];
}
