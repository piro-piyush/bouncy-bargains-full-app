
import 'package:bouncy_bargain/features/shop/screens/product/product_reviews/widgets/progress_indicator_rating.dart';
import 'package:flutter/material.dart';

class XOverallProductRatings extends StatelessWidget {
  const XOverallProductRatings({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '4.8',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        const Expanded(
          flex: 7,
          child: Column(
            children: [
              XRatingProgressIndicator(
                text: '5',
                value: 1.0,
              ),
              XRatingProgressIndicator(
                text: '4',
                value: 0.8,
              ),
              XRatingProgressIndicator(
                text: '3',
                value: 0.6,
              ),
              XRatingProgressIndicator(
                text: '2',
                value: 0.4,
              ),
              XRatingProgressIndicator(
                text: '1',
                value: 0.2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
