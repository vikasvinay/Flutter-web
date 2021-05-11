import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AdminRepository{
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AdminRepository(
      {FirebaseAuth firebaseAuth, FirebaseFirestore firebaseFirestore})
      : firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        firebaseFirestore = FirebaseFirestore.instance;

  Future<AdminModel> getaProduct({@required String productId}) async {
    AdminModel product;
    DocumentSnapshot map = await firebaseFirestore
        .collection("admin_products")
        .doc(productId)
        .get();
    product = AdminModel.getById(doc: map);
    return product;
  }

  Future<List<AdminModel>> getAllProducts({@required String category}) async {
    List<AdminModel> modelList = [];
    QuerySnapshot data =
        await firebaseFirestore.collection("admin_products").get();
    print(data.size);
    data.docs.forEach((element) async {
      if (element['product_category'].contains(category)) {
        modelList.add(AdminModel.fromFireStore(map: element.data()));
      }
    });
    return modelList;
  }

  // Stream<List<AdminModel>> getAllProductsStream({@required String category})  async*{
  //   List<AdminModel> modelList = [];
  //   Stream<QuerySnapshot<Map<String, dynamic>>> data =
  //      await  firebaseFirestore.collection("admin_products").snapshots();
  // data.forEach((element) {
  //   if(element.)
  //  });

    // data.docs.forEach((element) async {
    //   if (element['product_category'].contains(category)) {
    //     modelList.add(AdminModel.fromFireStore(map: element.data()));
    //   }
    // });
    // return modelList;
  }

  // Future<List<AdminModel>> getMostLikedProducts(
  //     {@required String category}) async {
  //   List<AdminModel> modelList = [];
  //   QuerySnapshot data = await firebaseFirestore
  //       .collection("admin_products")
  //       .orderBy('liked')
  //       .limit(5)
  //       .get();
  //   data.docs.forEach((element) {
  //     if (element['product_category'].contains(category)) {
  //       modelList.add(AdminModel.fromFireStore(map: element.data()));
  //     }
  //   });
  //   return modelList;
  // }

  // Future<List<AdminModel>> getAllMostLikedProducts() async {
  //   List<AdminModel> modelList = [];
  //   QuerySnapshot data = await firebaseFirestore
  //       .collection("admin_products")
  //       .orderBy('liked')
  //       .limit(5)
  //       .get();
  //   data.docs.forEach((element) {
  //     modelList.add(AdminModel.fromFireStore(map: element.data()));
  //   });
  //   return modelList;
  // }
// }
// }