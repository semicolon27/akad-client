// To parse this JSON data, do
//
//     final sidebarItem = sidebarItemFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

SidebarItem sidebarItemFromJson(String str) =>
    SidebarItem.fromJson(json.decode(str));

String sidebarItemToJson(SidebarItem data) => json.encode(data.toJson());

class SidebarItem {
  SidebarItem({
    this.title,
    this.route,
    this.icon,
    this.iconActive,
    this.svg,
    this.svgActive,
    this.children,
  });

  String? title;
  String? route;
  IconData? icon;
  IconData? iconActive;
  String? svg;
  String? svgActive;
  List<Map<String, dynamic>>? children;

  factory SidebarItem.fromJson(Map<String, dynamic> json) => SidebarItem(
        title: json["title"],
        route: json["route"],
        icon: json["icon"],
        iconActive: json["iconActive"],
        svg: json["svg"],
        svgActive: json["svgActive"],
        children:
            List<Map<String, dynamic>>.from(json["children"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "route": route,
        "icon": icon,
        "iconActive": iconActive,
        "svg": svg,
        "svgActive": svgActive,
        "children":
            List<Map<String, dynamic>>.from((children ?? []).map((x) => x)),
      };
}
