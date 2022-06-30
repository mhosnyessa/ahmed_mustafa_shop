import 'cat_item.dart';

class Cat{
List<CatItem>items=[];
void addItem(CatItem item){
items.add(item);
}
void removeItem(String prodID){
var index= items.indexWhere((element) => element.product.id==prodID);
items.removeAt(index);
}
double total(){
  double sum=0.0;
  items.forEach((element) {
    sum=sum+element.totalprice();
  });
  return sum;
}
}