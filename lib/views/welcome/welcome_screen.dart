import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sustomer_flutter_task/constants/app_colors.dart';
import 'package:sustomer_flutter_task/constants/app_images.dart';
import 'package:sustomer_flutter_task/constants/constants.dart';
import 'package:sustomer_flutter_task/controllers/question_controller.dart';
import 'package:sustomer_flutter_task/views/quiz/quiz_screen.dart';

import '../quiz/components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  QuestionController _questionController = Get.put(QuestionController());

  @override
  void initState() {
    // TODO: implement initState
    if (!mounted) {
      getQuestions();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kGradientStartColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer(flex: 2),2/6
            Expanded(
              flex: 8,
              child: Image.asset(
                AppImages.splash_illustration,
                fit: BoxFit.contain,
              ),
            ),
            Text(
              "Let's Play Quiz,",
              style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: AppColors.kBlackColor, fontWeight: FontWeight.bold),
            ),

            Spacer(), // 1/6

            // Spacer(), // 1/6
            CustomButton(
              text: 'Get Started',
              onTap: () {
                Get.to(() => QuizScreen());
              },
            ),
            Spacer(flex: 2), // it will take 2/6 spaces
          ],
        ),
      ),
    );
  }

  void getQuestions() async {
    await _questionController.getAllQ();
  }
}
