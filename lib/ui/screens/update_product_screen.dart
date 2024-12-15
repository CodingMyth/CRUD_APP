import 'dart:convert';

import 'package:assignment_3_crud_app/model/product_class.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  static const String name = '/update-product';

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTETEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();

  //flag variable
  bool _updateProductInProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTEController.text = widget.product.productName ?? '';
    _priceTEController.text = widget.product.unitPrice ?? '';
    _totalPriceTETEController.text = widget.product.totalPrice ?? '';
    _quantityTEController.text = widget.product.quantity ?? '';
    _imageTEController.text = widget.product.image ?? '';
    _codeTEController.text = widget.product.productCode ?? '';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildProductForm(),
        ),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
      // TODO : complete from validation






      child: Column(
        children: [
          TextFormField(
            controller: _nameTEController,
            decoration: const InputDecoration(
                hintText: 'Name',
                labelText: 'Product Name'
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Enter Product name';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _priceTEController,
            decoration: const InputDecoration(
                hintText: 'price',
                labelText: 'Product Price'
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Enter Product price';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _totalPriceTETEController,
            decoration: const InputDecoration(
                hintText: 'product price',
                labelText: 'Product Total Price'
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Enter Product Total Price';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _quantityTEController,
            decoration: const InputDecoration(
                hintText: 'quantity',
                labelText: 'Product Quantity'
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Enter Product Quantity';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _imageTEController,
            decoration: const InputDecoration(
                hintText: 'image',
                labelText: 'Product Image'
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Enter Product Image';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _codeTEController,
            decoration: const InputDecoration(
                hintText: 'code',
                labelText: 'Product Code'
            ),
            validator: (String? value) {
              if (value
                  ?.trim()
                  .isEmpty ?? true) {
                return 'Enter Product Code';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: _updateProductInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(onPressed: (){
              _updateProduct();
              //TODO : check form validation



            }, child: const Text('Update Product')),
          )
        ],
      ),
    );
  }


  Future<void> _updateProduct()async{
    _updateProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}');
    Map<String,dynamic> requestBody = {
      "Img":_imageTEController.text.trim(),
      "ProductCode":_codeTEController.text.trim(),
      "ProductName":_nameTEController.text.trim(),
      "Qty":_quantityTEController.text.trim(),
      "TotalPrice":_priceTEController,
      "UnitPrice":_priceTEController.text.trim(),
    };
    Response response = await post(
        uri,
        headers: {'Content-type':'application/json' },
        body: jsonEncode(requestBody));
    print(response.statusCode);
    print(response.body);
    _updateProductInProgress = false;
    setState(() {});
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
              content: Text('Product has been updates')));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Product updated failed')));
    }


  }
  @override
  void dispose() {
    _nameTEController;
    _priceTEController;
    _totalPriceTETEController;
    _quantityTEController;
    _imageTEController;
    _codeTEController;
    super.dispose();
  }
}

