import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hns_calculator/common/ui/RectangularButton.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> getProducts() async {
    final bool available = await InAppPurchase.instance.isAvailable();
    if (available) {
      // The store cannot be reached or accessed. Update the UI accordingly.
      const Set<String> _kIds = <String>{'hns_subscription_0_99'};
      final ProductDetailsResponse response =
      await InAppPurchase.instance.queryProductDetails(_kIds);
      if (response.notFoundIDs.isNotEmpty) {
        // Handle the error.
      }
      List<ProductDetails> products = response.productDetails;
    }else{
      print("error");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: const Color.fromRGBO(250, 250, 250, 1),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: const Center(
                    child: Text(
                  "Settings",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Urbanist'),
                )),
              ),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, top: 56),
                padding: EdgeInsets.only(left: 16, right: 16),
                height: 56,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromRGBO(237, 243, 255, 1),
                      width: 1,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Theme",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Urbanist'),
                    ),
                    Row(
                      children: [
                        const Text(
                          "System default",
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromRGBO(168, 168, 168, 1),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Urbanist'),
                        ),
                        SvgPicture.asset("assets/icons/icon_chevron.svg",
                            height: 24,
                            width: 24,
                            semanticsLabel: 'A red up arrow'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24,),
              RectangularButton(
                onTap: () {
                  getProducts();
                  // InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
                },
                text: "No Ads for 0.99",
              )
            ],
          ),
        ),
      ),
    );
  }
}
