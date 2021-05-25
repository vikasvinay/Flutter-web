import 'package:ecommerce_admin/services/mobx/login/login_service.dart';
import 'package:ecommerce_admin/services/routing/page_names.dart';
import 'package:ecommerce_admin/ui/edit_and%20_add_product.dart';
import 'package:ecommerce_admin/ui/error_page.dart';
import 'package:ecommerce_admin/ui/home_page.dart';
import 'package:ecommerce_admin/ui/login_page.dart';
import 'package:ecommerce_admin/ui/messages_page.dart';
import 'package:ecommerce_admin/ui/orders/order_categories.dart';
import 'package:ecommerce_admin/ui/orders/order_list.dart';
import 'package:ecommerce_admin/ui/products_categories.dart';
import 'package:ecommerce_admin/ui/view_all_products.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class FluroRoute {
  static final FluroRouter router = FluroRouter();

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
    List args = ModalRoute.of(context).settings.arguments;
    return AllProducts(
      categoryName: args[0],
      fromOrders: args[1],
    );
  });
  static Handler _categories =
      Handler(handlerFunc: (context, params) => Categories());

  static Handler _orderCategories =
      Handler(handlerFunc: (context, params) => OrderCategories());

  static Handler _orderlist = Handler(handlerFunc: (context, params) {
    var args = ModalRoute.of(context).settings.arguments;
    return OrdersList(productId: args);
  });

  static Handler _messages =
      Handler(handlerFunc: (context, params) => MessagesPage());

  static Handler _pageError = Handler(handlerFunc: (context, params) {
    Auth _auth = Provider.of<Auth>(context);
    _auth.logout();
    return ErrorPage();
  });

  static void setupRouter() {
    router.define(RouteNames.login, handler: _login);
    router.define(RouteNames.home, handler: _home);
    router.define(RouteNames.allProducts, handler: _allProducts);
    router.define(RouteNames.editProduct, handler: _edit);
    router.define(RouteNames.addProduct, handler: _add);
    router.define(RouteNames.categories, handler: _categories);
    router.define(RouteNames.ordersCategories, handler: _orderCategories);
    router.define(RouteNames.orderList, handler: _orderlist);
    router.define(RouteNames.messages, handler: _messages);
    router.notFoundHandler = _pageError;
  }
}
