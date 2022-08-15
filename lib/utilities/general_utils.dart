import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../configurations/size_config.dart';
import '../constants/app_colors.dart';

class GeneralUtils{
  static Widget loaderWidget() {
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.028,
      width: SizeConfig.screenWidth! * 0.06,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        color: AppColors.kLightGreySlideToolTipColor,
      ),
    );
  }
  static showMessage(
      {required BuildContext context,
        required String title,
        required String text}) {
    return EasyLoading.showToast(text,
        duration: const Duration(seconds: 3),
        toastPosition: EasyLoadingToastPosition.bottom);
  }
}