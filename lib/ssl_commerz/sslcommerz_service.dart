import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCShipmentInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';

import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';
import 'package:paikarilimited_quicktech/Boilerplate/boilerplateCheckOutScreen.dart';
import 'package:paikarilimited_quicktech/Controllers/provider/cartprovider.dart';
import 'package:paikarilimited_quicktech/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';

Future<void> sslCommerzService({
  required double totalAmount,
  required String phoneNumber,
  required String name,
  required String shipAddress,
  required String city,
  required String emailAddress,
  required int orderId,
  required BuildContext context,
}) async {
  LoadingDialog().dismiss();

  Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
          //Use the ipn if you have valid one, or it will fail the transaction.
          ipn_url: "www.paikarilimited.com",
          // multi_card_name: formData['multicard'],
          currency: SSLCurrencyType.BDT,
          product_category: "miscellaneous",
          sdkType: SSLCSdkType.LIVE,
          store_id: "paikarilimitedlive",
          store_passwd: "6123214799A7865576",
          total_amount: totalAmount,
          tran_id: "1231321321321312"));

  sslcommerz
      .addShipmentInfoInitializer(
          sslcShipmentInfoInitializer: SSLCShipmentInfoInitializer(
              shipmentMethod: "yes",
              numOfItems: 5,
              shipmentDetails: ShipmentDetails(
                  shipAddress1: shipAddress,
                  shipCity: city,
                  shipCountry: "Bangladesh",
                  shipName: name,
                  shipPostCode: "1203")))
      .addCustomerInfoInitializer(
          customerInfoInitializer: SSLCCustomerInfoInitializer(
              customerState: city,
              customerName: name,
              customerEmail: emailAddress,
              customerAddress1: shipAddress,
              customerCity: city,
              customerPostCode: "1203",
              customerCountry: "Bangladesh",
              customerPhone: phoneNumber));

  var result = await sslcommerz.payNow();
  if (result is PlatformException) {
    print("the response is: " +
        result.message.toString() +
        " code: " +
        result.code);
  } else {
    SSLCTransactionInfoModel model = result;
    Fluttertoast.showToast(
        msg: "Transaction successful: Amount ${model.amount} TK",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    Provider.of<CartProvider>(context, listen: false).clearCart();
    Get.off(() => BoilerplateChekOutScreen(
          orderid: orderId,
          paymentMethod: "Paid via SslCommerz",
        ));
  }
}

Future<void> sslCommerzGeneralCall() async {
  Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
          //Use the ipn if you have valid one, or it will fail the transaction.
          ipn_url: "www.paikarilimited.com",
          currency: SSLCurrencyType.BDT,
          product_category: "Food",
          sdkType: SSLCSdkType.TESTBOX,
          store_id: "paikarilimitedlive",
          store_passwd: "6123214799A7865576",
          total_amount: 5000,
          tran_id: "1231321321321312"));
  sslcommerz.payNow();
}
