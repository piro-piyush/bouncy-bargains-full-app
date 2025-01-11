import 'package:ecommerce_admin_panel/common/widgets/containers/rounded_container.dart';
import 'package:ecommerce_admin_panel/features/shop/models/brand_model.dart';
import 'package:ecommerce_admin_panel/utils/constants/image_strings.dart';
import 'package:ecommerce_admin_panel/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:iconsax/iconsax.dart';

class ProductsBrand extends StatelessWidget {
  const ProductsBrand({super.key});

  @override
  Widget build(BuildContext context) {
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Brand Label
          Text(
            "Brand",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),

          // TypeAheadField for Brand Selection
          TypeAheadField(
            builder: (context, ctr, focusNode) {
              return TextFormField(
                focusNode: focusNode,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Select Brand",
                    suffixIcon: Icon(Iconsax.box)),
              );
            },
            suggestionsCallback: (pattern) {
              // Return filtered brand suggestions bases on the search pattern
              return [
                BrandModel(id: "id", name: "Adidas", image: TImages.adidasLogo),
                BrandModel(id: "id", name: "Nike", image: TImages.adidasLogo),
              ];
            },
            itemBuilder: (context, suggestions) {
              return ListTile(title: Text(suggestions.name));
            },
            onSelected: (suggestion) {},
          )
        ],
      ),
    );
  }
}
