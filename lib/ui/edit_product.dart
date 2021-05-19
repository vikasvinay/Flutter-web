import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/models/model.dart';
import 'package:ecommerce_admin/services/repository/admin_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  final String productId;

  const EditProduct({Key key, this.productId}) : super(key: key);
  @override
  _EditProductState createState() => _EditProductState();
}

enum AllCategories { Kitchen, Home, Travel, Baby, Bathroom, Stationary }
AdminRepository _adminRepository = AdminRepository();

class _EditProductState extends State<EditProduct> {
  String image;
  bool stainlessSteel = false;
  bool reusable = false;
  bool environmentalFriendly = false;
  bool safeEdge = false;
  bool suitable = false;
  bool cleaningBrush = false;
  bool error = false;
  String _categoryType = 'Home';

  var categoriesList = [
    AllCategories.Kitchen,
    AllCategories.Home,
    AllCategories.Travel,
    AllCategories.Baby,
    AllCategories.Bathroom,
    AllCategories.Stationary,
  ];

  var categories = <String>[
    'Kitchen',
    'Home',
    'Travel',
    'Baby',
    'Bathroom',
    'Stationary'
  ];


  //// product Details
  TextEditingController _imageUrl = TextEditingController();
  TextEditingController _productName =
      TextEditingController();
  TextEditingController _productCompany =
      TextEditingController();
  TextEditingController _productPrice =
      TextEditingController();
  TextEditingController _productemissions =
      TextEditingController();
  TextEditingController _productplastic =
      TextEditingController();
  TextEditingController _productKp = TextEditingController();

//// About product _productemissions
  TextEditingController _madeSustainable =
      TextEditingController();
  TextEditingController _madeNonSustainable =
      TextEditingController();
  TextEditingController _disposalSustainable =
      TextEditingController();
  TextEditingController _disposalNonSustainable =
      TextEditingController();
  TextEditingController _degradeSustainable =
      TextEditingController();
  TextEditingController _degradeNonSustainable =
      TextEditingController();
  TextEditingController _about = TextEditingController();
  TextEditingController _material = TextEditingController();
  TextEditingController _packing = TextEditingController();
  TextEditingController _benefits = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  final storage = FirebaseStorage.instance;
  String downloadUrl;

  clearText() {
    _imageUrl.clear();
    _productName.clear();
    // _productCategory.clear();
    _about.clear();
    _degradeNonSustainable.clear();
    _madeNonSustainable.clear();
    _madeSustainable.clear();
    _packing.clear();
    _productKp.clear();
    _disposalSustainable.clear();
    _disposalNonSustainable.clear();
    _productPrice.clear();
    _benefits.clear();
    _material.clear();
    _degradeSustainable.clear();
    _disposalNonSustainable.clear();
    _productplastic.clear();
    _productemissions.clear();
    _productCompany.clear();
  }

  AllCategories _categories = AllCategories.Home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text("${widget.productId == null ? "Add product": "Edit product"}"),
        ),
        body: widget.productId != null
            ? FutureBuilder<AdminModel>(
                future:
                    _adminRepository.getaProduct(productId: widget.productId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  var item = snapshot.requireData;
                  print("has data");
                  print("${item.about}");
                  _imageUrl.text = item.imageUrl;
_productName.text = item.productName;
_productCompany.text = item. productCompany;
_productPrice.text = item. productPrice.toString();
_productemissions.text = item.productemissions.toString() ;
_productplastic.text = item.productplastic.toString() ;
_productKp.text = item.productKp.toString() ;
_madeSustainable.text = item.madeSustainable ;
_madeNonSustainable.text = item.madeNonSustainable ;
_disposalSustainable.text = item.disposalSustainable ;
_disposalNonSustainable.text = item. disposalNonSustainable;
_degradeSustainable.text = item.degradeSustainable ;
_degradeNonSustainable.text = item. degradeNonSustainable;
_about.text = item.about ;
_material.text = item.material ;
_packing.text = item.packing ;
_benefits.text = item.benefits ;
                  return main(
                      );
                })
            : main());
  }

  Widget main(
  ) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Text(
              "Product image: ",
              style: style(fontSize: 18.sp),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.r),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 120.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      image: DecorationImage(
                          image: NetworkImage(image != null && image.length > 2
                              ? image
                              : "https://images.unsplash.com/photo-1593642634402-b0eb5e2eebc9?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80"),
                          fit: BoxFit.fill)),
                ),
                Container(
                  height: 100.h,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      textField(controller: _imageUrl, hintName: "Image Url"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  image = _imageUrl.text.trim();
                                });
                              },
                              child: Text("Add")),
                          SizedBox(
                            width: 10.w,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                pickImage();
                              },
                              child: Text("Select from device")),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Text(
              "Product details: ",
              style: style(fontSize: 18.sp),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FractionColumnWidth(.2),
                      1: FractionColumnWidth(.2),
                      2: FractionColumnWidth(.1),
                      3: FractionColumnWidth(.2),
                      4: FractionColumnWidth(.2)
                    },
                    children: [
                      TableRow(children: [
                        Text("Name: ", style: style()),
                        smallTextField(controller: _productName, hintName: "name"),
                        SizedBox(
                          height: 10.h,
                        ),

                        ///
                        Text("Company: ", style: style()),
                        smallTextField(controller: _productCompany, hintName: "company name")
                      ]),
                      TableRow(children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "K.P after buying: ",
                          style: style(),
                        ),
                        textField(controller: _productKp, hintName: "0"),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text("Product price(₹): ", style: style()),
                        intTextField(controller: _productPrice, hintName: "0")
                      ]),
                      TableRow(children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ]),
                      TableRow(children: [
                        Text(
                          "less plastic pollution(%): ",
                          style: style(),
                        ),
                        intTextField(controller: _productplastic, hintName: "0"),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text("less co2 emissions(%): ", style: style()),
                        intTextField(
                            controller: _productemissions, hintName: "0")
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Text(
              "Category: ",
              style: style(fontSize: 18.sp),
            ),
          ),
          Container(
            width: 0.4.sw,
            height: 0.2.sh,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categoriesList.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 0.2.sw,
                    child: ListTile(
                      title: Text(categories[index]),
                      leading: Radio<AllCategories>(
                        value: categoriesList[index],
                        groupValue: _categories,
                        onChanged: (AllCategories value) {
                          setState(() {
                            _categories = value;
                            _categoryType = categories[value.index];
                          });
                          print(_categories == categoriesList[index]);
                          print(_categories);
                          print(_categoryType);
                        },
                      ),
                    ),
                  );
                }),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Text(
              "About Product: ",
              style: style(fontSize: 18.sp),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "How is this better",
                    style: style(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: {
                      0: FractionColumnWidth(.2),
                      1: FractionColumnWidth(.1),
                      2: FractionColumnWidth(.2),
                      3: FractionColumnWidth(.1),
                      4: FractionColumnWidth(.2)
                    },
                    children: [
                      TableRow(children: [
                        Text("", style: style()),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text("Sustainable", style: style()),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text("Non-Sustainable", style: style()),
                      ]),
                      TableRow(children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ]),
                      TableRow(children: [
                        Text("Made from: ", style: style()),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(controller: _madeSustainable, hintName: ""),
                        SizedBox(
                          height: 5.h,
                        ),
                        textField(
                            controller: _madeNonSustainable, hintName: ""),
                      ]),
                      TableRow(children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ]),
                      TableRow(children: [
                        Text("Disposal ", style: style()),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                            controller: _disposalSustainable, hintName: ""),
                        SizedBox(
                          height: 5.h,
                        ),
                        textField(
                            controller: _disposalNonSustainable, hintName: ""),
                      ]),
                      TableRow(children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ]),
                      TableRow(children: [
                        Text("Time to degrade ", style: style()),
                        SizedBox(
                          height: 10.h,
                        ),
                        textField(
                            controller: _degradeSustainable, hintName: ""),
                        SizedBox(
                          height: 5.h,
                        ),
                        textField(
                            controller: _degradeNonSustainable, hintName: ""),
                      ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Type: ",
                    style: style(),
                  ),
                ),
                Container(
                  width: 1.sw,
                  height: 20.h,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Row(
                          children: [
                            Text(
                              "304 Stainless Steel:",
                              style: style(fontWeight: false, fontSize: 14.sp),
                            ),
                            Checkbox(
                                value: stainlessSteel,
                                onChanged: (value) {
                                  setState(() {
                                    stainlessSteel = !stainlessSteel;
                                  });
                                  print(stainlessSteel);
                                })
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Row(
                          children: [
                            Text(
                              "Round & Safe Edge:",
                              style: style(fontWeight: false, fontSize: 14.sp),
                            ),
                            Checkbox(
                                value: safeEdge,
                                onChanged: (value) {
                                  setState(() {
                                    safeEdge = !safeEdge;
                                  });
                                  print(safeEdge);
                                })
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Row(
                          children: [
                            Text(
                              "Reusable & Durable:",
                              style: style(fontWeight: false, fontSize: 14.sp),
                            ),
                            Checkbox(
                                value: reusable,
                                onChanged: (value) {
                                  setState(() {
                                    reusable = !reusable;
                                  });
                                  print(reusable);
                                })
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Row(
                          children: [
                            Text(
                              "With Cleaning Brush:",
                              style: style(fontWeight: false, fontSize: 14.sp),
                            ),
                            Checkbox(
                                value: cleaningBrush,
                                onChanged: (value) {
                                  setState(() {
                                    cleaningBrush = !cleaningBrush;
                                  });
                                  print(cleaningBrush);
                                })
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Row(
                          children: [
                            Text(
                              "Suitable Everywhere:",
                              style: style(fontWeight: false, fontSize: 14.sp),
                            ),
                            Checkbox(
                                value: suitable,
                                onChanged: (value) {
                                  setState(() {
                                    suitable = !suitable;
                                  });
                                  print(suitable);
                                })
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Row(
                          children: [
                            Text(
                              "Health & Environmental Friendly:",
                              style: style(fontWeight: false, fontSize: 14.sp),
                            ),
                            Checkbox(
                                value: environmentalFriendly,
                                onChanged: (value) {
                                  setState(() {
                                    environmentalFriendly =
                                        !environmentalFriendly;
                                  });
                                  print(environmentalFriendly);
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (error)
                  Text(
                    "select any one.",
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(
                  height: 20.h,
                ),
                if (!error)
                  Text(
                    "Select minimum 1, and maximum 3..",
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(
                  height: 40.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "About: ",
                    style: style(),
                  ),
                ),
                Container(
                  width: 0.4.sw,
                  height: 0.1.sh,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty || value == null || value.length < 3) {
                        return "Can't be blank";
                      }
                      return null;
                    },
                    expands: true,
                    maxLines: null,
                    controller: _about,
                    decoration:
                        InputDecoration(enabledBorder: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Benefits: ",
                    style: style(),
                  ),
                ),
                Container(
                  width: 0.4.sw,
                  height: 0.1.sh,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty || value == null || value.length < 3) {
                        return "Can't be blank";
                      }
                      return null;
                    },
                    expands: true,
                    maxLines: null,
                    controller: _benefits,
                    decoration:
                        InputDecoration(enabledBorder: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Materials: ",
                    style: style(),
                  ),
                ),
                Container(
                  width: 0.4.sw,
                  height: 0.1.sh,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty || value == null || value.length < 3) {
                        return "Can't be blank";
                      }
                      return null;
                    },
                    expands: true,
                    maxLines: null,
                    controller: _material,
                    decoration:
                        InputDecoration(enabledBorder: OutlineInputBorder()),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Packaging: ",
                    style: style(),
                  ),
                ),
                Container(
                  width: 0.4.sw,
                  height: 0.1.sh,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty || value == null || value.length < 3) {
                        return "Can't be blank";
                      }
                      return null;
                    },
                    expands: true,
                    maxLines: null,
                    controller: _packing,
                    decoration:
                        InputDecoration(enabledBorder: OutlineInputBorder()),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 125.w, vertical: 18.h),
              child: MaterialButton(
                onPressed: validate,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                color: Colors.red,
                hoverColor: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.black, fontSize: 20.sp),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget smallTextField({String hintName, TextEditingController controller}) {
    return Container(
      width: 100.w,
      child: TextFormField(
        controller: controller,
        maxLength: 15,
        validator: (value) {
          if (value.isEmpty || value == null || (value.trim()).length < 3) {
            return "Can't be blank";
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: hintName, enabledBorder: OutlineInputBorder()),
      ),
    );
  }

  Widget textField({String hintName, TextEditingController controller}) {
    return Container(
      width: 100.w,
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.isEmpty || value == null || (value.trim()).length < 3) {
            return "Can't be blank";
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: hintName, enabledBorder: OutlineInputBorder()),
      ),
    );
  }

  Widget intTextField({String hintName, TextEditingController controller}) {
    return Container(
      width: 50.w,
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: controller,
        validator: (value) {
          if (int.tryParse(value.trim()) == null) {
            return "Can't be blank and it should be a number";
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: hintName, enabledBorder: OutlineInputBorder()),
      ),
    );
  }

  TextStyle style({Color color, bool fontWeight = true, double fontSize}) {
    return TextStyle(
      color: color ?? Colors.black,
      fontWeight: fontWeight ? FontWeight.bold : FontWeight.normal,
      fontSize: fontSize ?? 14.sp,
    );
  }

  validate() async {
    if (_formKey.currentState.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Uploading wait")));
      if (widget.productId == null) {
        var doc =
            await FirebaseFirestore.instance.collection("admin_products").doc();
        if (_imageFile != null) {
          try {
            var uploadTask = await storage
                .ref("admin_products/${doc.id}.jpg")
                .putData(await _imageFile.readAsBytes());
            await uploadTask.ref
                .getDownloadURL()
                .then((value) => image = value);
          } catch (e) {
            debugPrint(e.toString());
          }
        }

        print("-------------$image------------");
        await doc.set({
          "product_id": doc.id,
          "image_url": _imageUrl.text.trim().length != 0
              ? _imageUrl.text.trim()
              : image != null
                  ? image
                  : "https://images.unsplash.com/photo-1593642634402-b0eb5e2eebc9?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
          'stainless_steel': stainlessSteel,
          'reusable': reusable,
          'environmental_friendly': environmentalFriendly,
          'safe_edge': safeEdge,
          'suitable': suitable,
          'cleaning_brush': cleaningBrush,
          "product_name": _productName.text.trim(),
          "product_category": _categoryType, //_productCategory.text.trim(),
          "product_company": _productCompany.text.trim(),
          "product_price": int.parse(_productPrice.text.trim()),
          "product_emission": int.parse(_productemissions.text.trim()),
          "product_plastic": int.parse(_productplastic.text.trim()),
          "product_kp": int.parse(_productKp.text.trim()),
          "made_sustainable": _madeSustainable.text.trim(),
          "made_nonsustainable": _madeNonSustainable.text.trim(),
          "disposal_sustainable": _disposalSustainable.text.trim(),
          "disposal_nonsustainable": _disposalNonSustainable.text.trim(),
          "degrade_sustainable": _degradeSustainable.text.trim(),
          "degrade_nonsustainable": _degradeNonSustainable.text.trim(),
          "about": _about.text.trim(),
          "material": _material.text.trim(),
          "packing": _packing.text.trim(),
          "timeStamp": DateTime.now(),
          "liked": 1,
          "benefits": _benefits.text.trim(),
        }, SetOptions(merge: true)).then((value) => clearText());
      }if(widget.productId != null){
        print("has id");
        var doc =
             FirebaseFirestore.instance.collection("admin_products").doc(widget.productId);
        if (_imageFile != null) {
          try {
            var uploadTask = await storage
                .ref("admin_products/${widget.productId}.jpg")
                .putData(await _imageFile.readAsBytes());
            await uploadTask.ref
                .getDownloadURL()
                .then((value) => image = value);
          } catch (e) {
            debugPrint(e.toString());
          }
        }

        print("-------------$image----$doc--------");
        await doc.update({
          "product_id": widget.productId,
          "image_url": _imageUrl.text.trim().length != 0
              ? _imageUrl.text.trim()
              : image != null
                  ? image
                  : "https://images.unsplash.com/photo-1593642634402-b0eb5e2eebc9?ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80",
          'stainless_steel': stainlessSteel,
          'reusable': reusable,
          'environmental_friendly': environmentalFriendly,
          'safe_edge': safeEdge,
          'suitable': suitable,
          'cleaning_brush': cleaningBrush,
          "product_name": _productName.text.trim(),
          "product_category": _categoryType, //_productCategory.text.trim(),
          "product_company": _productCompany.text.trim(),
          "product_price": int.parse(_productPrice.text.trim()),
          "product_emission": int.parse(_productemissions.text.trim()),
          "product_plastic": int.parse(_productplastic.text.trim()),
          "product_kp": int.parse(_productKp.text.trim()),
          "made_sustainable": _madeSustainable.text.trim(),
          "made_nonsustainable": _madeNonSustainable.text.trim(),
          "disposal_sustainable": _disposalSustainable.text.trim(),
          "disposal_nonsustainable": _disposalNonSustainable.text.trim(),
          "degrade_sustainable": _degradeSustainable.text.trim(),
          "degrade_nonsustainable": _degradeNonSustainable.text.trim(),
          "about": _about.text.trim(),
          "material": _material.text.trim(),
          "packing": _packing.text.trim(),
          "timeStamp": DateTime.now(),
          "liked": 1,
          "benefits": _benefits.text.trim(),
        },).then((value) => clearText());
      }

    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid")));
      setState(() {
        error = true;
      });
    }
  }

  pickImage() async {
    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFile = pickedFile;
      image = _imageFile.path;
    });
  }
}
