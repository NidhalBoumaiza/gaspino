import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class HomePageHShimmer extends StatelessWidget {
  const HomePageHShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
              child: Container(
                height: 162.h,
                width: 170.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(
                        1.0,
                        1.0,
                      ), // Offset in right and down directions
                      blurRadius: 7.0,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(5.0.w, 0.0.h, 5.0.w, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0.w, 5.0.h, 0.0.w, 0),
                          child: Container(
                            height: 100.h,
                            decoration: BoxDecoration(
                              color: const Color(0xffe0eee9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.0.w, 2.0.h, 0.0.w, 0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 8.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffe0eee9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.0.w, 2.0.h, 0.0.w, 0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 8.h,
                            width: 50.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffe0eee9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 3.h),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.0.w, 2.0.h, 0.0.w, 0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Container(
                            height: 8.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: const Color(0xffe0eee9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
