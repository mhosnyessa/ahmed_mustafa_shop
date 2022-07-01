import 'package:ahmed_mustafa_amazon/shared/data/product.dart';

class CatItem {
  Product product;
  int itemCount = 0;
  CatItem(this.product);
  double totalprice() => product.price * itemCount;
}
