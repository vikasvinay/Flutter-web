import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/services/routing/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCategories extends StatelessWidget {
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
        title: Text("Order Categories"),
      ),
      body: Container(
          child: GridView.builder(
              itemCount: categoryList.length,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Container(
                    width: 80.w,
                    height: 160.h,
                    child: MaterialButton(
                      color: Colors.grey[300],
                      hoverColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.r)),
                      onPressed: () {
                        FluroRoute.router.navigateTo(
                            context, RouteNames.allProducts,
                            routeSettings: RouteSettings(
                                arguments: [categoryList[index]['category'], true]));
                      },
                      elevation: 8,
                      child: Container(
                        margin: EdgeInsets.zero,
                        width: 190.w,
                        height: 400.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          image: DecorationImage(
                              image: NetworkImage(categoryList[index]['image']),
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
              })),
    );
  }
}
