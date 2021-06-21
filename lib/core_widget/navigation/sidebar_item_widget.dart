import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:akad/core_utilitas/utility_ui.dart';
import 'package:akad/models/sidebar_item.dart';
import 'package:akad/view_model/vm_sidebar.dart';

class SidebarItemW extends ViewModelWidget<SidebarVM> {
  final Map<String, dynamic>? data;

  SidebarItemW({
    @required this.data,
  });

  @override
  bool get disposeViewModel => false;

  @override
  bool get reactive => true;

  @override
  Widget build(BuildContext context, SidebarVM vm) {
    SidebarItem sidebarItem = SidebarItem.fromJson(data ?? {});

    IconData? iconAsset = sidebarItem.icon;
    IconData? iconActiveAsset = sidebarItem.iconActive;
    String? svgAsset = sidebarItem.svg;
    String? svgActiveAsset = sidebarItem.svgActive;
    String? title = sidebarItem.title;
    bool? isDropdown = (sidebarItem.children ?? []).length > 0;
    bool? isExtend = vm.isExtend(sidebarItem.route ?? '');
    bool? isActive = vm.isActive(sidebarItem.route ?? '');

    return Container(
      decoration: BoxDecoration(
        color: isActive && !isDropdown ? kSidebarExtend : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            hoverColor: Colors.red,
            focusColor: Colors.pink,
            onFocusChange: (value) => print("hello"),
            onTap: () {
              if (isDropdown) {
                bool isCurrent = sidebarItem.route == vm.extend;
                vm.extend = isCurrent ? "" : sidebarItem.route;
              } else {
                vm.active = sidebarItem.route;
                Get.toNamed(sidebarItem.route ?? '');
              }
            },
            child: Container(
              height: setHeight(45),
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 20,
                right: 10,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (iconAsset != null && iconAsset != "")
                    isActive || isExtend
                        ? Icon(iconActiveAsset, color: Colors.white)
                        : Icon(iconAsset, color: Colors.white),
                  if (svgAsset != null && svgAsset != "")
                    isActive || isExtend
                        ? SvgPicture.asset(
                            "assets/icon/sidebar/$svgActiveAsset",
                            height: setHeight(20),
                            width: setWidth(20),
                            color: Colors.white,
                          )
                        : SvgPicture.asset(
                            "assets/icon/sidebar/$svgAsset",
                            height: setHeight(20),
                            width: setWidth(20),
                            color: Colors.white,
                          ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      title ?? '',
                      style: textStyle.textStyleBody2.copyWith(
                        color: Colors.white,
                        fontSize: 13.5,
                        fontWeight: isActive || isExtend
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Spacer(),
                  if (isDropdown)
                    Icon(
                      isExtend
                          ? MaterialCommunityIcons.chevron_down
                          : MaterialCommunityIcons.chevron_right,
                      color: Colors.white,
                    )
                ],
              ),
            ),
          ),
          if (isDropdown && isExtend)
            Container(
              child: Column(
                children: sidebarItem.children!.map((element) {
                  return SidebarItemOneW(
                    data: element,
                    parentUrl: sidebarItem.route ?? '',
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }

  @override
  SidebarVM viewModelBuilder(BuildContext context) => SidebarVM();
}

class SidebarItemOneW extends ViewModelWidget<SidebarVM> {
  final Map<String, dynamic>? data;
  final String? parentUrl;

  SidebarItemOneW({
    @required this.data,
    this.parentUrl,
  });

  @override
  Widget build(BuildContext context, SidebarVM vm) {
    SidebarItem sidebarItem = SidebarItem.fromJson(data ?? {});

    String title = sidebarItem.title ?? '';
    String route = '$parentUrl${sidebarItem.route}';
    bool isDropdown = (sidebarItem.children ?? []).length > 0;
    bool isExtend = vm.isExtend(route);
    bool isActive = vm.isActive(route);

    return Container(
      decoration: BoxDecoration(
        color: isActive && !isDropdown ? kSidebarExtend : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            hoverColor: Colors.red,
            focusColor: Colors.pink,
            onFocusChange: (value) => print("hello"),
            onTap: () {
              if (isDropdown) {
                bool isCurrent = route == vm.extend;
                vm.extend = isCurrent ? parentUrl : route;
              } else {
                vm.active = route;
                Get.toNamed(route);
              }
            },
            child: Container(
              height: setHeight(40),
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 20,
                right: 10,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    child: isActive
                        ? Icon(
                            MaterialCommunityIcons.circle_small,
                            color: Colors.white,
                          )
                        : Text(""),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      title,
                      style: textStyle.textStyleBody2.copyWith(
                        fontFamily: "Nunito",
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: isActive || isExtend
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Spacer(),
                  if (isDropdown)
                    Icon(
                      isExtend
                          ? MaterialCommunityIcons.chevron_down
                          : MaterialCommunityIcons.chevron_right,
                      color: Colors.white,
                    ),
                ],
              ),
            ),
          ),
          if (isDropdown && isExtend)
            Container(
              child: Column(
                children: sidebarItem.children!.map((element) {
                  return SidebarItemTwoW(
                    data: element,
                    parentUrl: route,
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }

  SidebarVM viewModelBuilder(BuildContext context) => SidebarVM();
}

class SidebarItemTwoW extends ViewModelWidget<SidebarVM> {
  final Map<String, dynamic>? data;
  final String? parentUrl;

  SidebarItemTwoW({
    @required this.data,
    this.parentUrl,
  });

  @override
  Widget build(BuildContext context, SidebarVM vm) {
    SidebarItem sidebarItem = SidebarItem.fromJson(data ?? {});

    String title = sidebarItem.title ?? '';
    String route = '$parentUrl${sidebarItem.route}';
    bool isDropdown = (sidebarItem.children ?? []).length > 0;
    bool isExtend = vm.isExtend(route);
    bool isActive = vm.isActive(route);

    return Container(
      decoration: BoxDecoration(
        color: isActive && !isDropdown ? kSidebarExtend : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          InkWell(
            hoverColor: Colors.red,
            focusColor: Colors.pink,
            onFocusChange: (value) => print("hello"),
            onTap: () {
              if (isDropdown) {
                vm.extend = isExtend ? "" : route;
              } else {
                vm.active = route;
                Get.toNamed(route);
              }
            },
            child: Container(
              height: setHeight(40),
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
                left: 40,
                right: 10,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    child: isActive
                        ? Icon(
                            MaterialCommunityIcons.circle_small,
                            color: Colors.white,
                          )
                        : Text(""),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      title,
                      style: textStyle.textStyleBody2.copyWith(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: isActive || isExtend
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  Spacer(),
                  if (isDropdown) Icon(MaterialCommunityIcons.menu_right),
                ],
              ),
            ),
          ),
          if (isDropdown)
            Container(
              child: Column(
                children: [],
              ),
            )
        ],
      ),
    );
  }

  SidebarVM viewModelBuilder(BuildContext context) => SidebarVM();
}
