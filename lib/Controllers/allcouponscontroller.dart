import 'package:get/get.dart';
import 'package:paikarilimited_quicktech/Models/all_coupons_model.dart';
import 'package:paikarilimited_quicktech/Service/remotecoupons.dart';

class AllCouponsController extends GetxController {
  var couponsList = <AllCouponsModel>[].obs;

  @override
  void onInit() {
    fetchAllCoupons();
    super.onInit();
  }

  void fetchAllCoupons() async {
    var coupons = await CouponRemoteService.fetchAllCoupons();
    if (coupons != null) {
      couponsList.value = coupons;
      print("FETCH ALL COUPONS FROM CONTROLLER");
    }
  }
}
