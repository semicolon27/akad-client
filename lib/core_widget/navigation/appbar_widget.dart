import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:akad/core_utilitas/support_provider/login_provider.dart';
import 'package:akad/core_utilitas/utility_ui.dart';

// desktop
SliverAppBar sliverAppBarW() {
  return SliverAppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    toolbarHeight: setHeight(85),
    centerTitle: false,
    leadingWidth: setWidth(1000),
    leading: Container(
      padding: EdgeInsets.only(left: 30.sp),
      alignment: Alignment.centerLeft,
      height: setHeight(100),
      child: Text(
        Get.parameters['title'] ?? '',
        style: textStyle.textStyleH5.copyWith(
          fontWeight: FontWeight.w700,
          fontFamily: "Nunito",
        ),
      ),
    ),
    actions: [
      Container(
        padding: EdgeInsets.only(right: 30.sp),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: 20.sp,
                horizontal: 10.sp,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Nikita Khrushchev',
                    style: textStyle.textStyleSubtitle1.copyWith(
                      fontFamily: "Nunito",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'PT Gelar Tikar Jaya Abadi',
                    style: textStyle.textStyleCaption,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  "https://img.freepik.com/free-photo/half-profile-image-beautiful-young-woman-with-bob-hairdo-posing-gazing-with-eyes-full-reproach-suspicion-human-facial-expressions-emotions-reaction-feelings_343059-4660.jpg?size=626&ext=jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

// mobile
AppBar appBarW() {
  return AppBar(
    elevation: 0,
    backgroundColor: Color(0xff1A70F9),
    centerTitle: true,
    title: Text(
      Get.parameters['title'] ?? '',
      style: textStyle.textStyleH6.copyWith(
        fontWeight: FontWeight.w700,
        fontFamily: "Nunito",
        color: Colors.white,
      ),
    ),
  );
}

PreferredSize appBarWa() {
  return PreferredSize(
    preferredSize: Size.fromHeight(setHeight(120)),
    child: Container(
      height: setHeight(100),
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: kBorderColor,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            "Dashboard",
            style: textStyle.textStyleH4.copyWith(
              fontWeight: FontWeight.w700,
              fontFamily: "Nunito",
            ),
          ),
          Spacer(),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 20.sp,
                    horizontal: 10.sp,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nikita Khrushchev",
                        style: textStyle.textStyleSubtitle1.copyWith(
                          fontFamily: "Nunito",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "BPRS Ayam Terbang",
                        style: textStyle.textStyleCaption,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      "https://1721181113.rsc.cdn77.org/data/images/full/27708/ai-can-accurately-determine-personality-type-based-on-selfie-58-of-the-time.jpeg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
