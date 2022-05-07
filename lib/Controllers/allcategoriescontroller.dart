import 'package:get/get.dart';
import 'package:paikarilimited_quicktech/Models/all_categories_model.dart';
import 'package:paikarilimited_quicktech/Service/remoteallcategories.dart';

class AllCategoriesController extends GetxController {
  var categories_ = <AllCategoriesModel>[].obs;
  @override
  void onInit() {
    FetchAllCategories();
    super.onInit();
  }

  void FetchAllCategories() async {
    var categories = await AllCategoriesRemoteService.fetchallcategories();
    if (categories != null) {
      categories_.value = categories;
    }
  }
}
