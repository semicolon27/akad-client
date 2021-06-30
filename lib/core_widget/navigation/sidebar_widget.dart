import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:akad/core_utilitas/utility_ui.dart';
import 'package:akad/core_widget/navigation/sidebar_item_widget.dart';
import 'package:akad/core_widget/navigation/sidebar_route_list.dart';
import 'package:akad/view_model/vm_sidebar.dart';
import 'package:akad/view_model/vm_template.dart';

class SidebarWidget extends StatelessWidget {
  final TemplateVM? model;
  SidebarWidget({@required this.model});

  static final numItems = 3;

  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ViewModelBuilder<SidebarVM>.reactive(
      disposeViewModel: false,
      onModelReady: (vm) => vm.init(),
      viewModelBuilder: () => SidebarVM(),
      builder: (context, vm, _) {
        return SizedBox(
          width: 250,
          child: Drawer(
            elevation: 0,
            child: SafeArea(
              child: Container(
                width: 100,
                color: Color(0xff1A70F9),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Container(
                      height: setHeight(85),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: kBorderBlueColor),
                        ),
                      ),
                      child: Image.asset(
                        'assets/img/mitrasoft_white.png',
                        height: setHeight(40),
                      ),
                    ),
                    SizedBox(height: setHeight(30)),
                    Container(
                      child: Column(
                        children: _listMenu(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

List<Widget> _listMenu() {
  List<Widget> listMenu = [];
  sidebarItem.forEach((v) {
    bool isDropdown = v['children'].length > 0;
    Widget menu;

    menu = Column(
      children: [
        SidebarItemW(data: v),
      ],
    );

    listMenu.add(menu);
  });
  return listMenu;
}
