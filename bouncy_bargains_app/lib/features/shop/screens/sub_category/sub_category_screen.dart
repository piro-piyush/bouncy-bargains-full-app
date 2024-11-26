import 'package:bouncy_bargain/common/widgets/appbar/appbar.dart';
import 'package:bouncy_bargain/common/widgets/images/x_rounded_image.dart';
import 'package:bouncy_bargain/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:bouncy_bargain/common/widgets/texts/section_heading.dart';
import 'package:bouncy_bargain/utils/constants/image_strings.dart';
import 'package:bouncy_bargain/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const XAppBar(
        title: Text("Sports"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(XSizes.defaultSpace),
          child: Column(
            children: [
              // Banner
              const XRoundedImage(
                imageUrl: XImages.promoBanner4,
                applyImageRadius: true,
                width: double.infinity,
              ),
              const SizedBox(
                height: XSizes.spaceBtwSections,
              ),

              // Sub - Categories
              Column(
                children: [
                  // Heading
                  XSectionHeading(title: "Sports Shirts",onPressed: (){},),
                  const SizedBox(height: XSizes.spaceBtwItems/2,),

                    SizedBox(
                      height: 120,
                      child: ListView.separated(
                        separatorBuilder: (context,index) =>const SizedBox(width: XSizes.spaceBtwItems,),
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context,index) => const XProductCardHorizontal(),),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
