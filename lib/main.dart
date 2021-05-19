import 'package:ecommerce_admin/services/login_service.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/services/routing/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Auth _auth = Auth();
  @override
  void initState() {
    FluroRoute.setupRouter();
    super.initState();
  }

  ///
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: () {
      return Observer(builder: (_) {
        return MultiProvider(
          providers: [Provider<Auth>(create: (_) => _auth)],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Admin Products",
            initialRoute: _auth.pageState,
            onGenerateRoute: FluroRoute.router.generator,
            // home: Wrapper(),
          ),
        );
      });
    });
  }
}
