// To parse this JSON data, do
//
//     final sidebarItem = sidebarItemFromJson(jsonString);

import 'dart:convert';

SidebarItem sidebarItemFromJson(String str) =>
    SidebarItem.fromJson(json.decode(str));

String sidebarItemToJson(SidebarItem data) => json.encode(data.toJson());

class SidebarItem {
  SidebarItem({
    this.title,
    this.route,
    this.icon,
    this.children,
  });

  String? title;
  String? route;
  String? icon;
  List<Map<String, dynamic>>? children;

  factory SidebarItem.fromJson(Map<String, dynamic> json) => SidebarItem(
        title: json["title"],
        route: json["route"],
        icon: json["icon"],
        children:
            List<Map<String, dynamic>>.from(json["children"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "route": route,
        "icon": icon,
        "children":
            List<Map<String, dynamic>>.from((children ?? []).map((x) => x)),
      };
}
