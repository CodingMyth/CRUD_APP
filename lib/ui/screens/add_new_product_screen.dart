import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  static const String name = '/add-new-product';

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}


//working with view
class _AddNewProductScreenState extends State<AddNewProductScreen> {

  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _priceTEController = TextEditingController();
  final TextEditingController _totalPriceTETEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _addNewProductInProgress = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: _buildProductForm(),
        ),
      ),
    );
  }



  //method extraction
  Widget _buildProductForm() {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: TextInputType.number,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
            visible: _addNewProductInProgress == false,
            replacement:const Center(
              child: CircularProgressIndicator(),
            ),
            child: ElevatedButton(onPressed: (){
              if(_formkey.currentState!.validate()){
                  _addNewProduct();
              }
            }, child: const Text('Add Product')),
          )
        ],
      ),
    );
  }
  
  
  
  //Api call
  Future<void> _addNewProduct()async {
    _addNewProductInProgress=true;
    setState(() {});
    Uri uri =Uri.parse('https://crud.teamrabbil.com/api/v1/CreateProduct');
    Map<String, dynamic> requestBody ={
      "Img":_imageTEController.text.trim(),
      "ProductCode":_codeTEController.text.trim(),
      "ProductName":_nameTEController.text.trim(),
      "Qty":_quantityTEController.text.trim(),
      "TotalPrice":_priceTEController,
      "UnitPrice":_priceTEController.text.trim(),
    };
    Response response =  await post(
      uri ,
      headers: {'Content-type' : 'applicable/json'},
      body: jsonEncode(requestBody),);
    print(response.statusCode);
    print(response.body);
    _addNewProductInProgress = false;
    setState(() {});
    if(response.statusCode == 200){
      _clearTextFields();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New Product Added'),),);
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('New Product Add Failed'),),);
    }
  }

  //text field clear
  void _clearTextFields(){
    _nameTEController.clear();
    _priceTEController.clear();
    _totalPriceTETEController.clear();
    _quantityTEController.clear();
    _imageTEController.clear();
    _codeTEController.clear();
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _priceTEController.dispose();
    _totalPriceTETEController.dispose();
    _quantityTEController.dispose();
    _imageTEController.dispose();
    _codeTEController.dispose();
    super.dispose();
  }
}

