// ignore_for_file: non_constant_identifier_names

import 'package:get/state_manager.dart';
import 'package:paikarilimited_quicktech/Models/all_products_model.dart';
import 'package:paikarilimited_quicktech/Service/remotecategoryproducts.dart';

class CategoryProductsController extends GetxController {
  // final int? productid;
  // CategoryProductsController({required this.productid}) {
  //   print(productid);
  // }
  var categoryproductlist_ = <AllProductsModel>[].obs;

  @override
  void onInit() {
    FetchCategoryProducts();
    super.onInit();
  }

  void FetchCategoryProducts() async {
    var products = await CategoryProductsRemoteService.fetchallproducts(
        // categoryid: this.productid
        );
    // print("Controller catched - " + this.productid.toString());
    if (products != null) {
      categoryproductlist_.value = products;
      print(categoryproductlist_);
    }
  }
}
