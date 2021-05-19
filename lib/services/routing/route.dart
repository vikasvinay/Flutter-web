import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/ui/edit_product.dart';
import 'package:ecommerce_admin/ui/home_page.dart';
import 'package:ecommerce_admin/ui/login_page.dart';
import 'package:ecommerce_admin/ui/products_categories.dart';
import 'package:ecommerce_admin/ui/view_all_products.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class FluroRoute {
  static final FluroRouter router = FluroRouter();

  // static Handler _root = Handler(handlerFunc: (context, params) => Wrapper());
  static Handler _login =
      Handler(handlerFunc: (context, params) => LoginPage());
  static Handler _home = Handler(handlerFunc: (context, params) => HomePage());
  static Handler _edit = Handler(handlerFunc: (context, params) {
    var args = ModalRoute.of(context).settings.arguments;
    return EditProduct(
      productId: args,
    );
  });
  static Handler _add =
      Handler(handlerFunc: (context, params) => EditProduct());
  static Handler _allProducts = Handler(handlerFunc: (context, params) {
    var args = ModalRoute.of(context).settings.arguments;
    return AllProducts(
      categoryName: args,
    );
  });
  static Handler _categories =
      Handler(handlerFunc: (context, params) => Categories());

  static void setupRouter() {
    // router.define(RouteNames.root, handler: _root);

    router.define(RouteNames.login, handler: _login);
    router.define(RouteNames.home, handler: _home);
    router.define(RouteNames.allProducts, handler: _allProducts);
    router.define(RouteNames.editProduct, handler: _edit);
    router.define(RouteNames.addProduct, handler: _add);
    router.define(RouteNames.categories, handler: _categories);
    router.notFoundHandler = _login;
  }
}
