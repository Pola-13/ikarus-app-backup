import 'package:flutter/material.dart';
import 'package:ikarusapp/core/constants/colors.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        PriceCard(
          title: "DC",
          price: "6.55 EGP",
          description: "Fast, Powerful Highway Charging",
        ),
        SizedBox(height: 12),
        PriceCard(
          title: "AC",
          price: "3.39 EGP",
          description: "Standard, Slower Charging",
        ),
        SizedBox(height: 12),
        PriceCard(
          title: "Idle Fees",
          price: "1.75 EGP Every 5 Minutes",
          description: "Idle Fees Apply 5 Minutes After Charging Ends",
        ),
      ],
    );
  }
}

class PriceCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;

  const PriceCard({
    super.key,
    required this.title,
    required this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.neutral200Color, width: 1),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title  $price",
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),

          const SizedBox(height: 6),

          Text(
            description,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
