import 'package:ahmed_mustafa_amazon/home/data/product.dart';

class CartItem {
  Product product;
  int itemCount = 0;
  CartItem(this.product);
  double totalprice() => product.price * itemCount;
}
