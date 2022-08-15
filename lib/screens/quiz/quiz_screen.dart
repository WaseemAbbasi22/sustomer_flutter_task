import 'package:flutter/material.dart';
import 'package:sustomer_flutter_task/configurations/size_config.dart';

import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Body(),
    );
  }
}
