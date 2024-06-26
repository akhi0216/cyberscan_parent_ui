import 'package:cyberscan_parent_ui/constants/color_constants.dart';
import 'package:flutter/material.dart';

class ConnectionRequestPage extends StatelessWidget {
  const ConnectionRequestPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorConstants.mainGradient,
        ),
        child: Center(
          child: Text("There is no connection requests\n $id"),
        ),
     ),
);
}
}