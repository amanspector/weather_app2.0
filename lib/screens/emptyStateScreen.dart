import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/constants/colorConstant.dart';
import 'package:weather_app/constants/textConstant.dart';

class Emptystatescreen {
  static Widget emptyScreen(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 80,
          width: 80,
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              Theme.of(context).brightness == Brightness.light
                  ? Colorconstant.blackcolor
                  : Colorconstant.whitecolor,
              BlendMode.srcIn,
            ),
            child: Lottie.asset(
              "assets/lottie_json/not_available.json",
              fit: BoxFit.contain,
            ),
          ),
        ),
        Text(
          Textconstant.txt_searchForCity,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        SizedBox(height: 200),
      ],
    );
  }
}
