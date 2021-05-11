import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/model.dart';
import 'package:ecommerce_admin/services/repository/admin_repository.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_admin/services/palette.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class AllProducts extends StatefulWidget {
  final String categoryName;

  const AllProducts({Key key, @required this.categoryName}) : super(key: key);
  @override
  _AllProductsState createState() => _AllProductsState();
}

AdminRepository _adminRepository = AdminRepository();

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${widget.categoryName}"),
        ),
        body: PaginateFirestore(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          shrinkWrap: true,
          isLive: true,
          onError: (_) {
            return Text("$_");
          },
          query: FirebaseFirestore.instance
              .collection('admin_products')
              .where('product_category', isEqualTo: widget.categoryName),
          itemBuilderType: PaginateBuilderType.gridView,
          itemBuilder:
              (int index, BuildContext context, DocumentSnapshot snap) {
                print(snap.id);
                print("llllllllll");
            Map<String, dynamic> data = snap.data();
            print(data['product_company']);
            return Column(
              children: [
                check(
                  context: context,
                  from: data['product_company'],
                  image: data['image_url'],
                  points: data['product_kp'],
                  price: data['product_price'],
                  productName: data[''],
                  icon1: data['stainless_steel'],
                  icon2: data['safe_edge'],
                  icon4: data['reusable'],
                  icon3: data['cleaning_brush'],
                  icon5: data['suitable'],
                  icon6: data['environmental_friendly'],
                  id: data['product_id'],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RouteNames.editProduct,
                          arguments: data['product_id'],
                        );
                      },
                      child: Icon(Icons.edit),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('admin_products')
                            .doc(data['product_id'])
                            .delete();
                      },
                      child: Icon(Icons.delete),
                    )
                  ],
                )
              ],
            );
          },
        )
        // FutureBuilder<List<AdminModel>>(
        //   future: _adminRepository.getAllProducts(category: widget.categoryName),
        //   builder: (context, snap) {
        //     if (!snap.hasData) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }
        //     //OSOsHxAsTNjP5Yw1SBDZ
        //     return GridView.builder(
        //         itemCount: snap.requireData.length,
        //         padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
        //         gridDelegate:
        //             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        //         itemBuilder: (context, index) {
        //           var item = snap.requireData;
        //           return Column(
        //             children: [
        //               check(
        //                   context: context,
        //                   from: item[index].productCompany,
        //                   image: item[index].imageUrl,
        //                   points: item[index].productKp,
        //                   price: item[index].productPrice,
        //                   productName: item[index].productName,
        //                   icon1: item[index].stainlessSteel,
        //                   icon2: item[index].safeEdge,
        //                   icon4: item[index].reusable,
        //                   icon3: item[index].cleaningBrush,
        //                   icon5: item[index].suitable,
        //                   icon6: item[index].environmentalFriendly,
        //                   id: item[index].id),
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //                 children: [
        //                   MaterialButton(
        //                     onPressed: () {
        //                       Navigator.pushNamed(context, RouteNames.editProduct,
        //                           arguments: item[index].id);
        //                     },
        //                     child: Icon(Icons.edit),
        //                   ),
        //                   MaterialButton(
        //                     onPressed: () async {
        //                       await FirebaseFirestore.instance
        //                           .collection('admin_products')
        //                           .doc(item[index].id)
        //                           .delete();
        //                     },
        //                     child: Icon(Icons.delete),
        //                   )
        //                 ],
        //               )
        //             ],
        //           );
        //         });
        //   },
        // ),

        );
  }

  Widget check(
      {@required String image,
      @required int price,
      @required String productName,
      @required String from,
      @required BuildContext context,
      @required String id,
      @required bool icon1,
      @required bool icon2,
      @required bool icon3,
      @required bool icon4,
      @required bool icon5,
      @required bool icon6,
      @required int points}) {
    return Container(
      height: 0.4.sh,
      width: 0.28.sw,
      margin: EdgeInsets.all(10),
      // decoration: BoxDecoration(
      //     // color: Colors.blueAccent,
      //     borderRadius: BorderRadius.circular(20.r)),
      child: Material(
        borderRadius: BorderRadius.circular(20.r),
        elevation: 8,
        child: ListView(
          children: [
            Container(
              height: 0.2.sh,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  // color: Colors.amber,
                  borderRadius: BorderRadius.circular(20.r)),
              child: Row(
                children: [
                  Container(
                    height: 0.2.sh,
                    width: 0.1.sw,
                    margin: EdgeInsets.only(left: 25, right: 30),
                    decoration: BoxDecoration(
                        // color: Colors.deepOrangeAccent,
                        image: DecorationImage(
                            fit: BoxFit.fill, image: NetworkImage(image)),
                        borderRadius: BorderRadius.circular(20.r)),
                    // margin:EdgeInsets.all(10),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("$from"),
                        Spacer(
                          flex: 1,
                        ),
                        Text("$productName"),
                        Spacer(
                          flex: 2,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text("₹$price"),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40.h,
              // color: Colors.brown,
              // margin:EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (icon1)
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Palette.darkGreen,
                        child: SvgPicture.asset(
                          'assets/svg/steel.svg',
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        )),
                  // CircleAvatar(
                  //     radius: 15,
                  //     backgroundColor: Palette.darkGreen,
                  //     child: Icon(
                  //       Icons.location_on_outlined,
                  //       color: Colors.white,
                  //       size: 16,
                  //     )),
                  if (icon2)
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Palette.lightGreen,
                        child: SvgPicture.asset(
                          'assets/svg/safe.svg',
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        )),
                  // CircleAvatar(
                  //     radius: 15,
                  //     child: Icon(
                  //         Icons.local_drink_outlined,
                  //         color: Colors.white,
                  //         size: 16)),
                  if (icon3)
                    CircleAvatar(
                        radius: 15,
                        child: SvgPicture.asset(
                          'assets/svg/reusable.svg',
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        )),
                  // CircleAvatar(
                  //     radius: 15,
                  //     backgroundColor:
                  //         Palette.earthyColor,
                  //     child: Icon(Icons.beenhere_outlined,
                  //         color: Colors.white, size: 16)),
                  if (icon4)
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Palette.lightGreen,
                        child: SvgPicture.asset(
                          'assets/svg/brush.svg',
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        )),
                  // CircleAvatar(
                  //     radius: 15,
                  //     backgroundColor: Palette.darkGreen,
                  //     child: Icon(
                  //       Icons.location_on_outlined,
                  //       color: Colors.white,
                  //       size: 16,
                  //     )),
                  if (icon5)
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Palette.lightGreen,
                        child: SvgPicture.asset(
                          'assets/svg/check.svg',
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        )),
                  // CircleAvatar(
                  //     radius: 15,
                  //     child: Icon(
                  //         Icons.local_drink_outlined,
                  //         color: Colors.white,
                  //         size: 16)),
                  if (icon6)
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: Palette.earthyColor,
                        child: SvgPicture.asset(
                          'assets/svg/full-items-inside-a-shopping-bag.svg',
                          color: Colors.white,
                          width: 20,
                          height: 20,
                        )),
                  // CircleAvatar(
                  //     radius: 15,
                  //     backgroundColor:
                  //         Palette.earthyColor,
                  //     child: Icon(Icons.beenhere_outlined,
                  //         color: Colors.white, size: 16)),
                ],
              ),
            ),
            Container(
              height: 40.h,
              color: Colors.grey.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.event_available_sharp),
                  Expanded(
                    child: Text(
                      "  This product gets you $points Loopify Points and a smile from our planet!",
                      style: TextStyle(fontSize: 10.sp),
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Spacer(flex: 2,),
            Container(
              // color: Colors.blueAccent,
              height: 40.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.cyan,
                      ),
                      onPressed: () {}),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                    ),
                    autofocus: true,
                    child: Text("How is this better?"),
                    onPressed: () {},
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                    ),
                    autofocus: true,
                    child: Text("Add to bag"),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Spacer(flex: 1,),
          ],
        ),
      ),
    );
  }

  // GestureDetector(
  //           onTap: () {
  //             Navigator.pushNamed(context, RouteNames.editProduct,
  //                 arguments: id);
  //           },
  //           child: Container(
  //             alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(20.r),
  //               color: Colors.black.withOpacity(0.5),
  //             ),
  //             child: Icon(
  //               Icons.edit,
  //               size: 40.r,
  //               color: Colors.white,
  //             ),
  //           ),
  //         ),

  // Widget _productCard(
  //     {
  //     //   @required String image,
  //     // @required int price,
  //     // @required String productName,
  //     // @required String from,
  //     // @required BuildContext context,
  //     // @required String id,
  //     // @required int points
  //     }) {
  //   return Stack(
  //     children: [
  //       Container(
  //         height: 20,
  //           width: 20,
  //           decoration: ,

  //       ),
  //       Container(
  //           height: 20,
  //           width: 20,
  //           color: Colors.amber,
  //           child: Column(
  //             children: [
  //               Container(
  //                   padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 5.h),
  //                   alignment: Alignment.topLeft,
  //                   child: Row(
  //                     children: [
  //                       Container(
  //                           height: 100.h,
  //                           width: 40.w,
  //                           decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(80.r)),
  //                           child: Image.network(
  //                             image,
  //                             fit: BoxFit.fill,
  //                           )),
  //                       SizedBox(
  //                         width: 6.w,
  //                       ),
  //                       Column(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             "$from",
  //                             style: TextStyle(fontSize: 8.sp),
  //                           ),
  //                           SizedBox(
  //                             height: 20.h,
  //                           ),
  //                           Text(
  //                             "$productName",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold, fontSize: 12.sp),
  //                           ),
  //                           SizedBox(
  //                             height: 50.h,
  //                           ),
  //                           Text(
  //                             "Rs. $price",
  //                             style: TextStyle(
  //                                 fontWeight: FontWeight.bold, fontSize: 15.sp),
  //                           )
  //                         ],
  //                       )
  //                     ],
  //                   )),
  //               SizedBox(
  //                 height: 5.h,
  //               ),
  //               Container(
  //                 // height: Responsive.ismobile(context) ? 25.h:20.h,
  //                 color: Colors.grey.withOpacity(0.5),
  //                 child: Row(
  //                   children: [
  //                     Icon(Icons.event_available_sharp),
  //                     Expanded(
  //                       child: Text(
  //                         "  This product gets you $points Loopify Points and a smile from our planet!",
  //                         style: TextStyle(fontSize: 10.sp),
  //                         textAlign: TextAlign.justify,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               ),
  //               // Spacer(),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   IconButton(
  //                       icon: Icon(
  //                         Icons.favorite_border,
  //                         color: Colors.cyan,
  //                       ),
  //                       onPressed: () {}),
  //                   OutlinedButton(
  //                     style: OutlinedButton.styleFrom(
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(10.r)),
  //                       ),
  //                     ),
  //                     autofocus: true,
  //                     child: Text("How is this better?"),
  //                     onPressed: () {},
  //                   ),
  //                   OutlinedButton(
  //                     style: OutlinedButton.styleFrom(
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.all(Radius.circular(10.r)),
  //                       ),
  //                     ),
  //                     autofocus: true,
  //                     child: Text("Add to bag"),
  //                     onPressed: () {},
  //                   ),
  //                 ],
  //               ),
  //               // SizedBox(
  //               //   height: 10.h,
  //               // )
  //             ],
  //           )),
  //     ],
  //   );
  // }

}
