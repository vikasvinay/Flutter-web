import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/services/routing/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final categoryList = <Map>[
    {
      "image":
          "https://images.unsplash.com/photo-1526280760714-f9e8b26f318f?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=967&q=80",
      "name": "Stationary",
      "category": 'Stationary'
    },
    {
      "image":
          "https://image.freepik.com/free-photo/bath-accessories-children-color-background_392895-4805.jpg",
      "name": "Baby Products",
      "category": 'Baby'
    },
    {
      "image":
          "https://image.freepik.com/free-vector/set-bath-accessories-flat-illustration_74855-16240.jpg",
      "name": "Bathroom Utensils",
      "category": 'Bathroom'
    },
    {
      "image":
          "https://images.unsplash.com/photo-1583847268964-b28dc8f51f92?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
      "name": "Home Utensils",
      "category": 'Home'
    },
    {
      "image":
          "https://images.unsplash.com/photo-1496950866446-3253e1470e8e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1050&q=80",
      "name": "Travel Utensils",
      "category": 'Travel'
    },
    {
      "image":
          "https://image.freepik.com/free-vector/modern-various-kitchen-tools-flat-icon-set_74855-6572.jpg",
      "name": "Kitchen Utensils",
      "category": 'Kitchen'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Categories"),
          centerTitle: true,
        ),
        body: Container(
            child: GridView.builder(
                itemCount: categoryList.length,
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Container(
                      width: 80.w,
                      height: 160.h,
                      child: MaterialButton(
                        // padding: EdgeInsets.symmetric(
                        //     horizontal: 20.w, vertical: 20.h),
                        color: Colors.grey[300],
                        hoverColor: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r)),
                        onPressed: () {
                          // print(FirebaseAuth.instance.currentUser.uid);
                          FluroRoute.router.navigateTo(
                              context, RouteNames.allProducts,
                              routeSettings: RouteSettings(
                                  arguments: [categoryList[index]['category'], false]));
                          // Navigator.pushNamed(context, RouteNames.allProducts,
                          //     arguments: categoryList[index]['category']);
                        },
                        elevation: 8,
                        child: Container(
                          margin: EdgeInsets.zero,
                          width: 190.w,
                          height: 400.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            image: DecorationImage(
                                image:
                                    NetworkImage(categoryList[index]['image']),
                                fit: BoxFit.fill),
                          ),
                          child: Container(
                            margin: EdgeInsets.zero,
                            alignment: Alignment.center,
                            width: 190.w,
                            height: 410.h,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              categoryList[index]['name'],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.sp),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }))
        // FutureBuilder<QuerySnapshot>(
        //     future: FirebaseFirestore.instance.collection("admin_products").get(),
        //     builder: (context, snapshot) {
        //       if (!snapshot.hasData) {
        //         print("no data");
        //         return Center(
        //           child: CircularProgressIndicator(),
        //         );
        //       }
        //       print(snapshot.requireData.docs.length);
        //       return

        //     ListView(
        //   shrinkWrap: true,
        //   children: [
        //     Container(
        //       width: 1.sw,
        //       height: 0.45.sh,
        //       child: ListView(
        //           scrollDirection: Axis.horizontal,
        //           children: [...List.generate(5, (index) => check())]),
        //     ),
        //     Container(
        //       width: 1.sw,
        //       height: 0.45.sh,
        //       child: ListView(
        //           scrollDirection: Axis.horizontal,
        //           children: [...List.generate(5, (index) => check())]),
        //     ),
        //     Container(
        //       width: 1.sw,
        //       height: 0.45.sh,
        //       child: ListView(
        //           scrollDirection: Axis.horizontal,
        //           children: [...List.generate(5, (index) => check())]),
        //     ),
        //   ],
        // )

        //     GridView.builder(
        //     shrinkWrap: true,
        //     itemCount: 5,//snapshot.data.size,
        //     padding: EdgeInsets.symmetric(horizontal: 80, vertical: 60),
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //         crossAxisCount: 2),
        //     itemBuilder: (context, index) {
        // //       // var data = snapshot.requireData.docs[index];
        //       return Container(
        //         height: 0.2.sw,
        //         child: check());
        // Container(
        //   // height: 0.5.sh,
        //   width: 0.28.sw,
        //   margin: EdgeInsets.all(10),
        //   // decoration: BoxDecoration(
        //   //     // color: Colors.blueAccent,
        //   //     borderRadius: BorderRadius.circular(20.r)),
        //   child: Material(
        //     borderRadius: BorderRadius.circular(20.r),
        //     elevation: 8,
        //     child: ListView(
        //       children: [
        //         Container(
        //       height: 0.2.sh,
        //       margin: EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //           color: Colors.amber,
        //           borderRadius: BorderRadius.circular(20.r)),
        //       child: Row(
        //         children: [
        //           Container(
        //             height: 0.2.sh,
        //             width: 0.1.sw,
        //             margin: EdgeInsets.only(left: 25, right: 30),
        //             decoration: BoxDecoration(
        //                 color: Colors.deepOrangeAccent,
        //                 // image: DecorationImage(fit: BoxFit.fill, image: NetworkImage('')),
        //                 borderRadius: BorderRadius.circular(20.r)),
        //             // margin:EdgeInsets.all(10),
        //           ),
        //           Container(
        //             color: Colors.indigo,
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               children: [
        //                 Text("qwer"),
        //                 Spacer(
        //                   flex: 1,
        //                 ),
        //                 Text("!@#%^&*"),
        //                 Spacer(
        //                   flex: 2,
        //                 ),
        //                 Padding(
        //                   padding: EdgeInsets.only(bottom: 8.0),
        //                   child: Text("123456789"),
        //                 )
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //         ),
        //         Container(
        //       height: 40.h, color: Colors.brown,
        //       // margin:EdgeInsets.all(10),
        //         ),
        //         Container(
        //       height: 40.h,
        //       color: Colors.grey.withOpacity(0.5),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           Icon(Icons.event_available_sharp),
        //           Expanded(
        //             child: Text(
        //               "  This product gets you 10 Loopify Points and a smile from our planet!",
        //               style: TextStyle(fontSize: 10.sp),
        //               textAlign: TextAlign.justify,
        //               overflow: TextOverflow.ellipsis,
        //             ),
        //           ),
        //         ],
        //       ),
        //         ),
        //         // Spacer(flex: 2,),
        //         Container(
        //       // color: Colors.blueAccent,
        //       height: 40.h,
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           IconButton(
        //               icon: Icon(
        //                 Icons.favorite_border,
        //                 color: Colors.cyan,
        //               ),
        //               onPressed: () {}),
        //           OutlinedButton(
        //             style: OutlinedButton.styleFrom(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(10.r)),
        //               ),
        //             ),
        //             autofocus: true,
        //             child: Text("How is this better?"),
        //             onPressed: () {},
        //           ),
        //           OutlinedButton(
        //             style: OutlinedButton.styleFrom(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(10.r)),
        //               ),
        //             ),
        //             autofocus: true,
        //             child: Text("Add to bag"),
        //             onPressed: () {},
        //           ),
        //         ],
        //       ),
        //         ),
        //         // Spacer(flex: 1,),

        //       ],
        //     ),
        //   ),
        // );
        // //   _productCard(
        // //       from: data['product_company'],
        // //       image: data['image_url'],
        // //       points: data['product_kp'],
        // //       price: data['product_price'],
        // //       context: context,
        // //       productName: data['product_name']),
        // // );
        // }
        // }),
        // )
        );
  }
}
