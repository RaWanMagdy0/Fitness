import 'package:flutter/material.dart';

import '../../../../../core/utils/widget/shimmer_loading_widget.dart';

class ShimmerVideoCard extends StatelessWidget {
  const ShimmerVideoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ShimmerLoadingWidget(
                width: 100,
                height: 120,
                borderRadius: 10,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShimmerLoadingWidget(
                    width: double.infinity,
                    height: 20,
                    borderRadius: 8,
                  ),
                  const SizedBox(height: 5),
                  ShimmerLoadingWidget(
                    width: 150,
                    height: 16,
                    borderRadius: 8,
                  ),
                  const SizedBox(height: 4),
                  ShimmerLoadingWidget(
                    width: 120,
                    height: 16,
                    borderRadius: 8,
                  ),
                ],
              ),
            ),
            InkWell(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white24,
                ),
                child: const Center(
                  child: Icon(Icons.play_arrow, color: Colors.black26, size: 30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerVideoCardList extends StatelessWidget {
  const ShimmerVideoCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: ShimmerVideoCard(),
      ),
    );
  }
}
