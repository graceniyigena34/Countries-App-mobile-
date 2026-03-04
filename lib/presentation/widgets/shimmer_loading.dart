import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 40,
                color: Colors.white,
              ),
              title: Container(
                height: 16,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 14,
                margin: const EdgeInsets.only(top: 4),
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
