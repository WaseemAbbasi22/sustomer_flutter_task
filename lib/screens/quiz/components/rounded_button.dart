import 'package:flutter/material.dart';
import 'package:sustomer_flutter_task/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  var onTap;
  CustomButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.all(kDefaultPadding * 0.75), // 15
        decoration: BoxDecoration(
          gradient: kPrimaryGradient,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Text(
          text,
          style: Theme.of(context)
              .textTheme
              .button
          !.copyWith(color: Colors.black),
        ),
      ),
    );
  }
  
}
