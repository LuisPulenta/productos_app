import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct!),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      //appBar: AppBar(title: Text('ProductScreen')),
      body: SingleChildScrollView(
        //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(
                  url: productService.selectedProduct?.picture,
                ),
                Positioned(
                  top: 60,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 20,
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      final picker = ImagePicker();
                      // ignore: deprecated_member_use
                      final PickedFile? pickedFile = await picker.getImage(
                          source: ImageSource.camera, imageQuality: 100);
                      if (pickedFile == null) {
                        return;
                        //print('No seleccionó nada');
                      }
                      //print('Tenemos imagen ${pickedFile!.path}');
                      productService
                          .updateSelectedProductImage(pickedFile.path);
                    },
                  ),
                )
              ],
            ),
            _ProductForm(),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;

                final String? imageUrl = await productService.uploadImage();

                if (imageUrl != null) productForm.product.picture = imageUrl;

                await productService.saveOrCreateProduct(productForm.product);
              },
        child: productService.isSaving
            ? const CircularProgressIndicator(
                color: Colors.white,
              )
            : const Icon(Icons.save_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}

class _ProductForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        height: 305,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Nombre del producto', labelText: 'Nombre:'),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                initialValue: '${product.price}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value) {
                  if (double.tryParse(value) == null) {
                    product.price = 0;
                  } else {
                    product.price = double.parse(value);
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '\$150', labelText: 'Precio:'),
              ),
              const SizedBox(
                height: 30,
              ),
              SwitchListTile.adaptive(
                  title: const Text('Disponible'),
                  activeColor: Colors.indigo,
                  value: product.available,
                  onChanged: productForm.updateAvailability),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              offset: const Offset(0, 5),
              blurRadius: 5,
            )
          ]);
}
