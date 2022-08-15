import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sustomer_flutter_task/configurations/size_config.dart';
import 'package:sustomer_flutter_task/constants/app_colors.dart';
import 'package:sustomer_flutter_task/controllers/question_controller.dart';

import '../../../constants/constants.dart';

class Option extends StatelessWidget {
  const Option({
    Key? key,
    this.text,
    this.average,
    this.index,
    this.press,
  }) : super(key: key);
  final String? text;
  final int? index;
  final int? average;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuestionController>(
        init: QuestionController(),
        builder: (qnController) {
          Color getTheRightColor() {
            if (qnController.isAnswered) {
              if (index == qnController.correctAns) {
                return kGreenColor;
              } else if (index == qnController.selectedAns &&
                  qnController.selectedAns != qnController.correctAns) {
                return kRedColor;
              }
            }
            return kGrayColor;
          }

          IconData getTheRightIcon() {
            return getTheRightColor() == kRedColor ? Icons.close : Icons.done;
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: press,
                child: Container(
                  margin: EdgeInsets.only(top: kDefaultPadding),
                  padding: EdgeInsets.all(kDefaultPadding),
                  decoration: BoxDecoration(
                    border: Border.all(color: getTheRightColor()),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${index! + 1}. $text",
                        style:
                            TextStyle(color: getTheRightColor(), fontSize: 16),
                      ),
                      Container(
                        height: 26,
                        width: 26,
                        decoration: BoxDecoration(
                          color: getTheRightColor() == kGrayColor
                              ? Colors.transparent
                              : getTheRightColor(),
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: getTheRightColor()),
                        ),
                        child: getTheRightColor() == kGrayColor
                            ? null
                            : Icon(getTheRightIcon(), size: 16),
                      )
                    ],
                  ),
                ),
              ),

              qnController.isAnswered&&qnController.isNextTap
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.screenHeight!*0.02,),
                      Text(
                          average.toString() +'%',
                          style:
                              TextStyle(fontSize: 14, color: AppColors.kBlackColor),
                        ),
                    ],
                  )
                  : SizedBox(
                      height: 1.0,
                    ),
            ],
          );
        });
  }
}
