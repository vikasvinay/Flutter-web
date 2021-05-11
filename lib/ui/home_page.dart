import 'package:ecommerce_admin/services/login_service.dart';
import 'package:ecommerce_admin/services/repository/admin_repository.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
AdminRepository _adminRepository = AdminRepository();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin home"),
        actions: [
          Observer(builder: (_) {
            return TextButton.icon(
                onPressed: _auth.logoutPressed,
                // () async {
                //   await _auth.logout().then((value) =>
                //       Navigator.pushReplacementNamed(
                //           context, RouteNames.login));
                // },
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                  // print(FirebaseAuth.instance.currentUser.uid);
                  Navigator.pushNamed(context, RouteNames.addProduct);
                },
                elevation: 8,
                child: Text(
                  "Add Product",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
                ),
              ),
            ),
            Container(
              width: 80.w,
              height: 160.h,
              child: MaterialButton(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                color: Colors.grey[300],
                hoverColor: Colors.cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r)),
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.categories);
                },
                elevation: 8,
                child: Text("Uploaded products",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.sp)),
              ),
            ),
            // Container(
            //   width: 80.w,
            //   height: 160.h,
            //   child: MaterialButton(
            //     padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            //     color: Colors.grey[300],
            //     hoverColor: Colors.cyan,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(20.r)),
            //     onPressed: () {
            //       _adminRepository
            //     },
            //     elevation: 8,
            //     child: Text("check in",
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold, fontSize: 16.sp)),
            //   ),
            // )
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
      if (loggedout) Navigator.popUntil(context, ModalRoute.withName(RouteNames.login));
    });
  }
}
