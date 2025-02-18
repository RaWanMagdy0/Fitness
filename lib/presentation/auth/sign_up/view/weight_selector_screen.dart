import 'package:fitness_app/core/utils/widget/custom%20scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/styles/fonts/app_fonts.dart';
import '../../../../core/styles/images/app_images.dart';

void main() {
  runApp(const MaterialApp(home: WeightSelectionScreen()));
}

class WeightSelectionScreen extends StatefulWidget {
  const WeightSelectionScreen({Key? key}) : super(key: key);

  @override
  _WeightSelectionScreenState createState() => _WeightSelectionScreenState();
}

class _WeightSelectionScreenState extends State<WeightSelectionScreen> {
  int selectedWeight = 90;
  final int minWeight = 40;
  final int maxWeight = 120;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundImage: AppImages.authBackground,
      enableBlur: true,
      blurStrength: 5.0,
      blurHeight: 230,
      blurWidth: 430,
      borderRadius: 50.0,
      blurStartPosition: MediaQuery.of(context).size.height * 0.4.w,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(25.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 200.h),
              Text(
                "WHAT IS YOUR WEIGHT ?",
                style: AppFonts.font14WhiteWeight800.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 5),
              Text(
                "This Helps Us Create Your Personalized Plan",
                style: AppFonts.font18WhiteWeight400.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 20),

              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Kg",
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),

              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      itemCount: maxWeight - minWeight + 1,
                      itemBuilder: (context, index) {
                        int weight = minWeight + index;
                        bool isSelected = weight == selectedWeight;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedWeight = weight;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              weight.toString(),
                              style: TextStyle(
                                fontSize: isSelected ? 28 : 22,
                                fontWeight: FontWeight.bold,
                                color:
                                    isSelected ? Colors.orange : Colors.white70,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: -10,
                    child: Icon(Icons.arrow_drop_up,
                        color: Colors.orange, size: 24),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Next Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                    onPressed: () {
                      print("Selected Weight: $selectedWeight kg");
                    },
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
