import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentController {
  static Future<void> getProducts() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (available) {
      const Set<String> _kIds = <String>{'hns_subscription_0_99'};
      final ProductDetailsResponse response =
          await InAppPurchase.instance.queryProductDetails(_kIds);
      if (response.notFoundIDs.isNotEmpty) {
        // Handle the error.
      }
      List<ProductDetails> products = response.productDetails;
      final PurchaseParam purchaseParam =
          PurchaseParam(productDetails: products[0]);
      await InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      print("error");
    }
  }

  static void listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // _showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // _handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.purchased ||
            purchaseDetails.status == PurchaseStatus.restored) {
          // bool valid = await _verifyPurchase(purchaseDetails);
          // if (valid) {
          //   _deliverProduct(purchaseDetails);
          // } else {
          //   _handleInvalidPurchase(purchaseDetails);
          // }
        }
        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }
}
