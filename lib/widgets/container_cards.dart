import 'package:flutter/material.dart';

class ContainerCard extends StatelessWidget {
  const ContainerCard(
      {super.key,
      this.myColor,
      this.myCardDetails,
      this.onPress,
      this.height,
      this.width});

  final Color? myColor;
  final Widget? myCardDetails;
  final Function? onPress;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {onPress?.call()},
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(6.0),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: myColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: myCardDetails,
      ),
    );
  }
}
