import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustomer_flutter_task/configurations/size_config.dart';
import 'package:sustomer_flutter_task/constants/app_colors.dart';
import 'package:sustomer_flutter_task/constants/constants.dart';
import 'package:sustomer_flutter_task/controllers/question_controller.dart';

import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatefulWidget {
   Body({
    Key ?key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  QuestionController _questionController = Get.find<QuestionController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.kGradientStartColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.screenHeight!*0.07,),

            Padding(
              padding:
                   EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: ProgressBar(),
            ),
            SizedBox(height: kDefaultPadding),
            Padding(
              padding:
                   EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Obx(
                () => Text.rich(
                  TextSpan(
                    text:
                        "Question ${_questionController.questionNumber.value}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        !.copyWith(color: kSecondaryColor),
                    children: [
                      TextSpan(
                        text: "/${_questionController.allQuestions!.length}",
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            !.copyWith(color: kSecondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(thickness: 1.5),
            SizedBox(height: kDefaultPadding),
            Expanded(
              child: PageView.builder(
                // Block swipe to next qn
                physics: NeverScrollableScrollPhysics(),
                controller: _questionController.pageController,
                onPageChanged: _questionController.updateTheQnNum,
                itemCount: _questionController.allQuestions!.length,
                itemBuilder: (context, index) => QuestionCard(
                  index: index,
                  questionController: _questionController,
                ),
              ),
            ),
            // SizedBox(height: SizeConfig.screenHeight!*0.05),
          ],
        ),
      ),
    );
  }


}
