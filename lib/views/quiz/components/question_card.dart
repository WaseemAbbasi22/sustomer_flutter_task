import 'package:flutter/material.dart';
import 'package:sustomer_flutter_task/configurations/size_config.dart';
import 'package:sustomer_flutter_task/constants/app_colors.dart';
import 'package:sustomer_flutter_task/controllers/question_controller.dart';
import 'package:sustomer_flutter_task/models/question_model.dart';
import 'package:sustomer_flutter_task/views/quiz/components/rounded_button.dart';
import 'package:sustomer_flutter_task/utilities/general_utils.dart';

import '../../../constants/constants.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.index,
    required this.questionController,
  }) : super(key: key);

  // final List<QuestionM> question;
  final QuestionController questionController;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: SizeConfig.screenHeight!*0.3,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: FutureBuilder<List<Question>>(
        future: questionController.allQ,
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Question>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: GeneralUtils.loaderWidget());
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              final question = snapshot.data![index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.questionText!,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: kBlackColor),
                  ),
                  SizedBox(height: kDefaultPadding / 2),
                  ...List.generate(
                    question.answers!.length,
                    (index) => Option(
                      index: index,
                      text: question.answers![index].text,
                      average: question.answers![index].score,
                      press: () {
                        if (!questionController.isAnswered) {
                          questionController.checkAns(question, index);
                        } else {
                          GeneralUtils.showMessage(
                              context: context,
                              title: 'Info',
                              text: 'You can answer a question only once');
                          print('Already Answered...');
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight! * 0.06,
                  ),
                  CustomButton(
                      text: 'Show Average',
                      onTap: () {
                        questionController.setNextTap = true;
                      }),
                ],
              );
            } else {
              return const Text(
                'No Data found ',
                style: TextStyle(fontSize: 14, color: AppColors.kBlackColor),
              );
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}
