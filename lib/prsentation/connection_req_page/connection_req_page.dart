import 'package:cyberscan_parent_ui/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ConnectionRequestPage extends StatelessWidget {
  const ConnectionRequestPage(
      {super.key, required this.childId, required this.parentId});

  final String childId;
  final String parentId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorConstants.mainGradient,
        ),
        child: Center(
          child: Text("There is no connection requests\n$childId$parentId"),
        ),
      ),
    );
  }
}
