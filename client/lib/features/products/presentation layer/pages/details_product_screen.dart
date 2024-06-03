import 'package:client/core/widgets/reusable_text.dart';
import 'package:client/features/products/domain%20layer/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/colors.dart';
import '../../../../core/svg.dart';
import '../../../../core/widgets/my_customed_button.dart';
import '../../../commande/domain layer/entities/ordred_product.dart';
import '../../../commande/presentation layer/cubit/shopping card cubit/shopping_card_cubit.dart';
import '../cubit/product quantity cubit/product_quantity_cubit.dart';

class DetailsProductScreen extends StatefulWidget {
  final Product product;

  DetailsProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  _DetailsProductScreenState createState() => _DetailsProductScreenState();
}

class _DetailsProductScreenState extends State<DetailsProductScreen> {
  final DateFormat dateFormat = DateFormat('EEEE d MMMM', 'fr_FR');
  final DateFormat dateFormatForRecoveryDate =
      DateFormat('EEEE d MMMM, HH:mm', 'fr_FR');
  GoogleMapController? _controller;

  @override
  Widget build(BuildContext context) {
    final productQuantityCubit = context.read<ProductQuantityCubit>();
    LatLng location = LatLng(37.4219999, -122.0840575);

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: SizedBox(
            child: IconButton(
              icon: Icon(
                FontAwesomeIcons.circleArrowLeft,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.h,
                decoration: BoxDecoration(
                  color: const Color(0xffe0eee9),
                  image: DecorationImage(
                    image: NetworkImage(
                        "${dotenv.env["URLIMAGE"]}${widget.product.productPictures[0]}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(
                      text: widget.product.name,
                      textSize: 20.sp,
                      textFontWeight: FontWeight.w800,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: "Prix",
                              textSize: 15.sp,
                              textFontWeight: FontWeight.w800,
                            ),
                            Row(
                              children: [
                                widget.product.priceBeforeReduction != null
                                    ? Row(
                                        children: [
                                          ReusableText(
                                            text: widget.product
                                                    .priceBeforeReduction
                                                    .toString() +
                                                " DT",
                                            textSize: 14.sp,
                                            textColor: Colors.red,
                                            textFontWeight: FontWeight.w400,
                                            textDecoration:
                                                TextDecoration.lineThrough,
                                            lineThickness: 3.h,
                                          ),
                                          ReusableText(
                                              text: " / ", textSize: 12.sp),
                                        ],
                                      )
                                    : SizedBox(),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      0.0.w, 0.0.h, 0.0.w, 0),
                                  child: ReusableText(
                                    text:
                                        "${widget.product.priceAfterReduction} DT",
                                    textSize: 14.sp,
                                    textColor: Colors.green,
                                    textFontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // QUANTIITY OF PRODUCT
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  // Decrease the quantity of the product
                                  final currentQuantity = productQuantityCubit
                                          .state
                                          .quantities[widget.product.id] ??
                                      1;
                                  if (currentQuantity > 1) {
                                    productQuantityCubit.changeQuantity(
                                        widget.product.id, currentQuantity - 1);
                                  }
                                },
                                icon: Icon(FontAwesomeIcons.circleMinus,
                                    color: Colors.grey.shade400, size: 30.sp)),
                            // Display the current quantity of the product
                            BlocBuilder<ProductQuantityCubit,
                                ProductQuantityState>(
                              builder: (context, state) {
                                final quantity =
                                    state.quantities[widget.product.id] ?? 1;
                                return ReusableText(
                                    text: "$quantity", textSize: 15.sp);
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  // Increase the quantity of the product
                                  final currentQuantity = productQuantityCubit
                                          .state
                                          .quantities[widget.product.id] ??
                                      1;
                                  if (currentQuantity <
                                      widget.product.quantity) {
                                    productQuantityCubit.changeQuantity(
                                        widget.product.id, currentQuantity + 1);
                                  }
                                },
                                icon: Icon(FontAwesomeIcons.circlePlus,
                                    color: primaryColor, size: 30.sp)),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ReusableText(
                      text: "Quantité",
                      textSize: 15.sp,
                      textFontWeight: FontWeight.w800,
                    ),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.cartShopping,
                            color: Colors.black, size: 15.sp),
                        SizedBox(width: 10.w),
                        ReusableText(
                          text: widget.product.quantity.toString(),
                          textSize: 15.sp,
                          textFontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ReusableText(
                        text: "Date d'expiration",
                        textSize: 15.sp,
                        textFontWeight: FontWeight.w800),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.hourglassHalf,
                          color: primaryColor,
                          size: 15.sp,
                        ),
                        SizedBox(width: 5.w),
                        ReusableText(
                          text:
                              dateFormat.format(widget.product.expirationDate),
                          textSize: 14.sp,
                          textColor: Colors.black,
                          textFontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    widget.product.description != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReusableText(
                                text: "Description",
                                textSize: 15.sp,
                                textFontWeight: FontWeight.w800,
                              ),
                              ReusableText(
                                text: widget.product.description!,
                                textSize: 14.sp,
                                textFontWeight: FontWeight.w400,
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(height: 10.h),

                    ReusableText(
                      text: "Date préferée de récuperation",
                      textSize: 15.sp,
                      textFontWeight: FontWeight.w800,
                    ),
                    ReusableText(
                      text: "De " +
                          dateFormatForRecoveryDate
                              .format(widget.product.recoveryDate![0]!),
                      textSize: 14.sp,
                      textColor: Colors.black,
                      textFontWeight: FontWeight.w400,
                    ),
                    ReusableText(
                      text:
                          "Jusqu'à ${dateFormatForRecoveryDate.format(widget.product.recoveryDate![widget.product.recoveryDate!.length < 2 ? 0 : 1]!)}",
                      textSize: 14.sp,
                      textColor: Colors.black,
                      textFontWeight: FontWeight.w400,
                    ),
                    // TODO GOOGLE MAP WIDGET
                    // Container(
                    //   height: 160.h,
                    //   width: double.infinity,
                    //   child: GoogleMap(
                    //     initialCameraPosition: CameraPosition(
                    //       target: location,
                    //       zoom: 14.4746,
                    //     ),
                    //     markers: {
                    //       Marker(
                    //         markerId: MarkerId('location'),
                    //         position: location,
                    //       ),
                    //     },
                    //     onMapCreated: (GoogleMapController controller) {
                    //       _controller = controller;
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Icon(FontAwesomeIcons.person,
                            color: Colors.black, size: 15.sp),
                        SizedBox(width: 4.w),
                        ReusableText(
                          text: "Information de vendeur",
                          textSize: 15.sp,
                          textFontWeight: FontWeight.w800,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                            text: "Nom et prénom",
                            textSize: 14.sp,
                            textFontWeight: FontWeight.w800,
                          ),
                          ReusableText(
                            text: widget.product.productOwner.lastName +
                                " " +
                                widget.product.productOwner.firstName,
                            textSize: 14.sp,
                            textFontWeight: FontWeight.w400,
                          ),
                          SizedBox(height: 10.h),
                          ReusableText(
                            text: "Téléphone",
                            textSize: 14.sp,
                            textFontWeight: FontWeight.w800,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Call the phone number
                              launchUrl(Uri.parse(
                                  'tel://${widget.product.productOwner.phoneNumber}'));
                            },
                            child: ReusableText(
                              text: widget.product.productOwner.phoneNumber,
                              textSize: 14.sp,
                              textColor: Colors.blue,
                              textFontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                    MyCustomButton(
                      width: SizeScreen.width,
                      height: 50.h,
                      function: () {
                        final quantity = productQuantityCubit
                                .state.quantities[widget.product.id] ??
                            1;
                        final product =
                            OrderedProduct(widget.product, quantity, "pending");
                        context.read<ShoppingCardCubit>().addProduct(product);
                      },
                      buttonColor: primaryColor,
                      text: "Commander",
                      circularRadious: 15.sp,
                      textButtonColor: Colors.white,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
