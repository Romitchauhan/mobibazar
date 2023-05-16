import 'package:velocity_x/velocity_x.dart';

import 'cart.dart';
import 'catalog.dart';

class MyStore extends VxStore {
  CatalogModel catalog = CatalogModel();
  CartModel cart = CartModel();
  VxNavigator navigator = VxNavigator(routes: {});
  List<Item> items = [];

  MyStore() {
    cart.catalog = catalog;
  }
}
