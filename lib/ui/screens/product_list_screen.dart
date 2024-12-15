import 'dart:convert';
import 'package:assignment_3_crud_app/ui/screens/add_new_product_screen.dart';
import 'package:assignment_3_crud_app/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../model/product_class.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});


  @override
  State<ProductListScreen> createState() => _ProductListScreenState();

}
class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _getProductListInProgress = false;

  //api call
  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: const [],
      ),
      body: Visibility(
        visible: _getProductListInProgress == false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: ListView.builder(
          itemCount: productList.length,
          itemBuilder: (context, index) {
            return ProductItem(
              product: productList[index],
            );
          },),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewProductScreen.name);
        },
        child: const Icon(Icons.add),),
    );
  }



//Method api
  Future<void> _getProductList() async {
    _getProductListInProgress = true;
    setState(() {});
    Uri uri = Uri.parse('https://crud.teamrabbil.com/api/v1/ReadProduct');
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);
      print(decodedData['status']);
      for (Map<String, dynamic> p in decodedData['data']) {
        Product product = Product(
            id: p['id'],
            productName: p['ProductName'],
            productCode: p['ProductCode'],
            quantity: p['Qty'],
            unitPrice: p['UnitPrice'],
            image: p['Img'],
            totalPrice: p['TotalPrice'],
            createdDate: p['CreatedDate']
        );
        productList.add(product);
      }
      setState(() {});
    }
    _getProductListInProgress =false;
    setState(() {});
  }
}


















//widget extension
//Custom Widget
class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(

      title:  Text(product.productName ??''),
      subtitle:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Product code:${product.productCode}'),
          Text('Quantity:${product.quantity}'),
          Text('Price:${product.unitPrice}'),
          Text('Total Price:${product.totalPrice}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
              return AlertDialog(
                title: const Text('Do You Want to Delete'),
                actions: [
                  TextButton(onPressed: (){}, child: const Text('Yes')),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: const Text('No'))
                ],
              );
            });
          }, icon: const Icon(Icons.delete)),
          IconButton(onPressed: (){
            showDialog(context: context, builder: (context){
               return AlertDialog(
                 actions: [
                   TextButton(
                       onPressed: (){
                         Navigator.pushNamed(context, UpdateProductScreen.name);
                       },
                       child: const Text('Yes')),
                   TextButton(
                       onPressed: (){
                         Navigator.pop(context);
                       },
                       child: const Text('No')),
                 ],
                 title: const Text('Are you sure?'),

               );
            });
          }, icon: const Icon(Icons.edit)),
        ],),
    );
  }
}
