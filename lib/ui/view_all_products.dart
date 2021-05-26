import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/services/routing/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_admin/services/palette.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class AllProducts extends StatefulWidget {
  final String categoryName;
  final bool fromOrders;

  const AllProducts(
      {Key key, @required this.categoryName, this.fromOrders = false})
      : super(key: key);
  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("All Products"),
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
            Map<String, dynamic> data = snap.data();
            print(data['product_company']);
            return SizedBox(
              height: size.width / 20,
              width: size.width / 20,
              child: Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: check(
                        context: context,
                        from: data['product_company'],
                        image: data['image_url'],
                        points: data['product_kp'],
                        price: data['product_price'],
                        productName: data['product_name'],
                        icon1: data['stainless_steel'],
                        icon2: data['safe_edge'],
                        icon4: data['reusable'],
                        icon3: data['cleaning_brush'],
                        icon5: data['suitable'],
                        icon6: data['environmental_friendly'],
                        id: data['product_id'],
                        size: size),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (!widget.fromOrders)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            FluroRoute.router.navigateTo(
                                context, RouteNames.editProduct,
                                routeSettings: RouteSettings(
                                    arguments: data['product_id']));
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
                    ),
                  if (widget.fromOrders)
                    ElevatedButton(
                        onPressed: () {
                          FluroRoute.router.navigateTo(
                              context, RouteNames.orderList,
                              routeSettings:
                                  RouteSettings(arguments: data['product_id']));
                        },
                        child: Text("Check Orders")),
                  
                  Spacer()
                ],
              ),
            );
          },
        ));
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
      Size size,
      @required int points}) {
    return Material(
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
                  height: size.height / 8,
                  width: size.width / 10,
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
                      Text("$productName", style: TextStyle(fontWeight: FontWeight.bold),),
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
          // Container(
          //   // color: Colors.blueAccent,
          //   height: 40.h,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       IconButton(
          //           icon: Icon(
          //             Icons.favorite_border,
          //             color: Colors.cyan,
          //           ),
          //           onPressed: () {}),
          //       OutlinedButton(
          //         style: OutlinedButton.styleFrom(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10.r)),
          //           ),
          //         ),
          //         autofocus: true,
          //         child: Text("How is this better?"),
          //         onPressed: () {},
          //       ),
          //       OutlinedButton(
          //         style: OutlinedButton.styleFrom(
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.all(Radius.circular(10.r)),
          //           ),
          //         ),
          //         autofocus: true,
          //         child: Text("Add to bag"),
          //         onPressed: () {},
          //       ),
          //     ],
          //   ),
          // ),
          // // Spacer(flex: 1,),
        ],
      ),
    );
  }
}
