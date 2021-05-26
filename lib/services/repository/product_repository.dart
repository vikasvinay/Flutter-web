import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/models/product_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProductRepository {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  ProductRepository(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = FirebaseFirestore.instance;

  Future<ProductModel> getaProduct({@required String productId}) async {
    ProductModel product;
    DocumentSnapshot map = await firebaseFirestore
        .collection("admin_products")
        .doc(productId)
        .get();
    product = ProductModel.getById(doc: map);
    return product;
  }

  Future<List<ProductModel>> getAllProducts({@required String category}) async {
    List<ProductModel> modelList = [];
    QuerySnapshot data =
        await firebaseFirestore.collection("admin_products").get();
    print(data.size);
    data.docs.forEach((element) async {
      if (element['product_category'].contains(category)) {
        modelList.add(ProductModel.fromFireStore(map: element.data()));
      }
    });
    return modelList;
  }

  // Stream<List<ProductModel>> getAllProductsStream({@required String category})  async*{
  //   List<ProductModel> modelList = [];
  //   Stream<QuerySnapshot<Map<String, dynamic>>> data =
  //      await  firebaseFirestore.collection("admin_products").snapshots();
  // data.forEach((element) {
  //   if(element.)
  //  });

  // data.docs.forEach((element) async {
  //   if (element['product_category'].contains(category)) {
  //     modelList.add(ProductModel.fromFireStore(map: element.data()));
  //   }
  // });
  // return modelList;
}

  // Future<List<ProductModel>> getMostLikedProducts(
  //     {@required String category}) async {
  //   List<ProductModel> modelList = [];
  //   QuerySnapshot data = await firebaseFirestore
  //       .collection("admin_products")
  //       .orderBy('liked')
  //       .limit(5)
  //       .get();
  //   data.docs.forEach((element) {
  //     if (element['product_category'].contains(category)) {
  //       modelList.add(ProductModel.fromFireStore(map: element.data()));
  //     }
  //   });
  //   return modelList;
  // }

  // Future<List<ProductModel>> getAllMostLikedProducts() async {
  //   List<ProductModel> modelList = [];
  //   QuerySnapshot data = await firebaseFirestore
  //       .collection("admin_products")
  //       .orderBy('liked')
  //       .limit(5)
  //       .get();
  //   data.docs.forEach((element) {
  //     modelList.add(ProductModel.fromFireStore(map: element.data()));
  //   });
  //   return modelList;
  // }
// }
// }