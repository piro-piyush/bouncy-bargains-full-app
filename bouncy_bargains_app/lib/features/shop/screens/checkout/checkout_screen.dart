import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:bouncy_bargain/common/widgets/products/cart/coupon_widget.dart';
import 'package:bouncy_bargain/common/widgets/success_screen/success_screen.dart';
import 'package:bouncy_bargain/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:bouncy_bargain/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:bouncy_bargain/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:bouncy_bargain/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:bouncy_bargain/navigation_menu.dart';
import 'package:bouncy_bargain/utils/constants/colors.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:bouncy_bargain/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = XHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: XAppBar(
        title: Text(
          "Order Review",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            children: [
              // Items in Cart
              const XCartItems(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),

              // Coupon Text field
              const XCouponCode(),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),

              // Billing Section
              XRoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(XSizes.md),
                backgroundColor: dark ? XColors.black : XColors.white,
                child: const Column(
                  children: [
                    // Pricing
                    XBillingAmountSection(),
                    SizedBox(
                      height: XSizes.spaceBtwItems,
                    ),

                    // Divider
                    Divider(),
                    SizedBox(
                      height: XSizes.spaceBtwItems,
                    ),

                    // Payment Methods
                    XBillingPaymentSection(),
                    SizedBox(
                      height: XSizes.spaceBtwItems,
                    ),

                    // Address
                    XBillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(XSizes.defaultSpace),
        child: ElevatedButton(
            onPressed: () {
              Get.to(() => SuccessScreen(image: XImages.successfulPaymentIcon, title: "Payment Success", subTitle: "Your item will be shipped soon!", onPressed: () => Get.offAll(() => const NavigationMenu())));
            },
            child: const Text("Checkout \$323")),
      ),
    );
  }
}
