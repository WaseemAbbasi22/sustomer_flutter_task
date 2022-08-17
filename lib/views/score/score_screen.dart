import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sustomer_flutter_task/configurations/size_config.dart';
import 'package:sustomer_flutter_task/constants/app_colors.dart';
import 'package:sustomer_flutter_task/constants/constants.dart';
import 'package:sustomer_flutter_task/controllers/question_controller.dart';
import 'package:sustomer_flutter_task/views/quiz/quiz_screen.dart';
import 'package:sustomer_flutter_task/views/welcome/welcome_screen.dart';
import '../../views/quiz/components/rounded_button.dart';

class ScoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    QuestionController _qnController = Get.put(QuestionController());
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: AppColors.kGradientStartColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
          Column(
            children: [
              Spacer(flex: 3),
              Text(
                "Score",
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: AppColors.kBlackColor),
              ),
              Spacer(),
              Text(
                // Each question is equal to 10 marks,
                "${_qnController.correctAns != null ? _qnController.numOfCorrectAns*10 : 0 * 10}/${_qnController.allQuestions!.length * 10}",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: AppColors.kBlackColor),
              ),
              Spacer(flex: 3),
            ],
          )
        ],
      ),
    );
  }
}
