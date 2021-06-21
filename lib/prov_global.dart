import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:akad/provider/p_detail.dart';

List<ChangeNotifierProvider> multiProvider = [
  ChangeNotifierProvider<UtamaProvider>(
      create: (BuildContext context) => UtamaProvider()),
];
