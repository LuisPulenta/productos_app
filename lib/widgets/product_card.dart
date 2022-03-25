import 'dart:ui';

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(),
            _ProductDetails(),
            Positioned(
              right: 0,
              top: 0,
              child: _PriceTag(),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: _NotAvailable(),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black45, offset: Offset(0, 7), blurRadius: 10)
        ]);
  }
}

class _BackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _ProductDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disco duro G',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Id del disco duro',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(color: Colors.black45, offset: Offset(0, 7), blurRadius: 10)
        ]);
  }
}

class _PriceTag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 7), blurRadius: 10)
          ]),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '\$103.99',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.yellow[800],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black45, offset: Offset(0, 7), blurRadius: 10)
          ]),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'No disponible',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
