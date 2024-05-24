import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/svg.dart';

class AddImage extends StatelessWidget {
  double? height, width, borderRadious;
  dynamic image;
  String? imageString;
  void Function()? onPress;

  AddImage(
      {Key? key,
      this.width,
      this.height,
      this.borderRadious,
      this.image,
      this.onPress,
      this.imageString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: DottedBorder(
        color: Colors.black,
        strokeWidth: 2,
        borderType: BorderType.Rect,
        dashPattern: const [10, 10, 10, 10],
        child: image == null && imageString == null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SvgPicture.string(addImage),
                ),
              )
            : Stack(
                children: [
                  Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageString == null
                            ? MemoryImage(image!) as ImageProvider
                            : NetworkImage(
                                "${dotenv.env['URL']}${imageString!}"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0.sp,
                    top: 0.sp,
                    child: GestureDetector(
                      onTap: onPress,
                      child: SvgPicture.asset("assets/Xmark.svg"),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
