import 'package:ecommerce_admin/services/mobx/homePage/home_service.dart';
import 'package:ecommerce_admin/services/mobx/login/login_service.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/services/routing/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Auth _auth = Auth();
  HomeController _homeController = HomeController();
  @override
  void initState() {
    _homeController.getProfile();
    super.initState();
  }

  String companyName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: () {
          FluroRoute.router.navigateTo(context, RouteNames.messages);
        },
      ),
      appBar: AppBar(
        title: Observer(builder: (_) {
          return Text(_homeController.companyName.toUpperCase());
        }),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Observer(builder: (_) {
            return TextButton.icon(
                onPressed: _auth.logoutPressed,
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 20.r,
                ),
                label: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    "Log out",
                    style: TextStyle(color: Colors.black, fontSize: 18.sp),
                  ),
                ));
          })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 80.w,
                  height: 160.h,
                  child: MaterialButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    color: Colors.grey[300],
                    hoverColor: Colors.lightGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    onPressed: () {
                      FluroRoute.router
                          .navigateTo(context, RouteNames.addProduct);
                    },
                    elevation: 8,
                    child: Text(
                      "Add Product",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.sp),
                    ),
                  ),
                ),
                Container(
                  width: 80.w,
                  height: 160.h,
                  child: MaterialButton(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    color: Colors.grey[300],
                    hoverColor: Colors.cyan,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r)),
                    onPressed: () {
                      FluroRoute.router
                          .navigateTo(context, RouteNames.categories);
                    },
                    elevation: 8,
                    child: Text("Uploaded products",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16.sp)),
                  ),
                ),
              ],
            ),
            Container(
              width: 80.w,
              height: 160.h,
              child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                color: Colors.grey[300],
                hoverColor: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                onPressed: () {
                  FluroRoute.router
                      .navigateTo(context, RouteNames.ordersCategories);
                },
                elevation: 8,
                child: Text(
                  "Orders",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ReactionDisposer disposer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _auth = Provider.of<Auth>(context);
    disposer = reaction((_) => _auth.loggedOut, (loggedout) {
      if (loggedout)
        FluroRoute.router.navigateTo(context, RouteNames.login,
            clearStack: true, replace: true);
    });
  }
}
