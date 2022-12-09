import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hns_calculator/common/ui/RectangularButton.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../components/item_radio.dart';

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
    } else {
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
              GestureDetector(
                onTapUp: (tap) {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16))),
                      builder: (context) {
                        return FractionallySizedBox(
                            heightFactor:
                                300 / MediaQuery.of(context).size.height,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Center(
                                  child: Container(
                                    width: 40,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                        color: Color.fromRGBO(188, 188, 188, 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 11,
                                ),
                                const Center(
                                  child: Text(
                                    "Theme",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontFamily: 'Urbanist'),
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Expanded(
                                    child: Column(
                                  children: const [
                                    ItemRadio(
                                      text: "Light",
                                      isSelected: true,
                                    ),
                                    ItemRadio(
                                      text: "Dark - Coming Soon",
                                      isSelected: false,
                                    ),
                                    ItemRadio(
                                      text: "System Default - Coming Soon",
                                      isSelected: false,
                                    )
                                  ],
                                ))
                              ],
                            ));
                      });
                },
                child: Container(
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
              ),
              const SizedBox(
                height: 24,
              ),
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
