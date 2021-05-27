import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProductModel {
  bool stainlessSteel;
  bool reusable;
  bool environmentalFriendly;
  bool safeEdge;
  bool suitable;
  bool cleaningBrush;
  List imageUrl;
  String productName;
  String productCategory;
  String productCompany;
  int productPrice;
  int productemissions;
  int productplastic;
  int productKp;
  String madeSustainable;
  String madeNonSustainable;
  String disposalSustainable;
  String disposalNonSustainable;
  String degradeSustainable;
  String degradeNonSustainable;
  String about;
  String material;
  String packing;
  String id;
  String adminId;
  String benefits;
  Timestamp timeStamp;
  String searchName;
  int liked;

  ProductModel(
      {@required this.stainlessSteel,
      @required this.reusable,
      @required this.environmentalFriendly,
      @required this.safeEdge,
      @required this.suitable,
      @required this.searchName,
      @required this.cleaningBrush,
      @required this.imageUrl,
      @required this.productName,
      @required this.productCategory,
      @required this.productCompany,
      @required this.adminId,
      @required this.productPrice,
      @required this.productemissions,
      @required this.productplastic,
      @required this.productKp,
      @required this.madeSustainable,
      @required this.madeNonSustainable,
      @required this.disposalSustainable,
      @required this.disposalNonSustainable,
      @required this.degradeSustainable,
      @required this.degradeNonSustainable,
      @required this.about,
      @required this.material,
      @required this.packing,
      @required this.id,
      @required this.timeStamp,
      @required this.benefits,
      @required this.liked});

  ProductModel.fromFireStore({@required Map<String, dynamic> map}) {
    this.stainlessSteel = map['stainless_steel'];
    this.searchName = map['search_name'];
    this.reusable = map['reusable'];
    this.environmentalFriendly = map['environmental_friendly'];
    this.safeEdge = map['safe_edge'];
    this.suitable = map['suitable'];
    this.cleaningBrush = map['cleaning_brush'];
    this.adminId = map['admin_id'];
    this.imageUrl = map['image_url'];
    this.productName = map['product_name'];
    this.productCategory = map['product_category'];
    this.productCompany = map['product_company'];
    this.productPrice = map['product_price'];
    this.productemissions = map['product_emission'];
    this.productplastic = map['product_plastic'];
    this.productKp = map['product_kp'];
    this.madeSustainable = map['made_sustainable'];
    this.madeNonSustainable = map['made_nonsustainable'];
    this.disposalSustainable = map['disposal_sustainable'];
    this.disposalNonSustainable = map['disposal_nonsustainable'];
    this.degradeSustainable = map['degrade_sustainable'];
    this.degradeNonSustainable = map[''];
    this.about = map['about'];
    this.material = map['material'];
    this.packing = map['packing'];
    this.id = map['product_id'];
    this.timeStamp = map['timeStamp'];
    this.liked = map['liked'];
    this.benefits = map['benefits'];
  }
  factory ProductModel.getById({@required DocumentSnapshot doc}) {
    return ProductModel(
      searchName: doc['search_name'],
        adminId: doc['admin_id'],
        stainlessSteel: doc['stainless_steel'],
        reusable: doc['reusable'],
        environmentalFriendly: doc['environmental_friendly'],
        safeEdge: doc['safe_edge'],
        suitable: doc['suitable'],
        cleaningBrush: doc['cleaning_brush'],
        imageUrl: doc['image_url'],
        productName: doc['product_name'],
        productCategory: doc['product_category'],
        productCompany: doc['product_company'],
        productPrice: doc['product_price'],
        productemissions: doc['product_emission'],
        productplastic: doc['product_plastic'],
        productKp: doc['product_kp'],
        madeSustainable: doc['made_sustainable'],
        madeNonSustainable: doc['made_nonsustainable'],
        disposalSustainable: doc['disposal_sustainable'],
        disposalNonSustainable: doc['disposal_nonsustainable'],
        degradeSustainable: doc['degrade_sustainable'],
        degradeNonSustainable: doc['degrade_nonsustainable'],
        about: doc['about'],
        material: doc['material'],
        packing: doc['packing'],
        id: doc['product_id'],
        timeStamp: doc['timeStamp'],
        liked: doc['liked'],
        benefits: doc['benefits']);
  }
}
