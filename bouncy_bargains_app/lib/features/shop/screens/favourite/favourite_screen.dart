import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/icons/circular_icon.dart';
import 'package:bouncy_bargain/common/widgets/layouts/grid_layout.dart';
import 'package:bouncy_bargain/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: XAppBar(
        title: Text(
          'Wishlist',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          XCircularIcon(
            icon: Iconsax.add,
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            children: [
              XGridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    return const XProductCardVertical();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
