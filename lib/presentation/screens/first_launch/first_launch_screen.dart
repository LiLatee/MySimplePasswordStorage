import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/app_key_cubit.dart';
import '../../widgets_templates/field_widget.dart';

class FirstLaunchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Welcome in my app!\nI am sorry... in YOUR app!",
              style: Theme.of(context).textTheme.headline3,
              softWrap: true,
            ),
            Text(
              "I see you here for the first time. I need just one thing and then you can start to use your beautifull app.",
              style: Theme.of(context).textTheme.bodyText1,
              softWrap: true,
            ),
            Text(
              "That thing is a key/password which is going to use to encrypt Your precious data.",
              style: Theme.of(context).textTheme.bodyText1,
              softWrap: true,
            ),
            // FieldWidget(
            //   label: 'Your Key',
            //   readOnly: false,
            //   controller: controller,
            // ),
            TextButton(
              onPressed: () {
                BlocProvider.of<AppKeyCubit>(context).generateKey();
                // ScaffoldMessenger.of(context)
                //     .showSnackBar(SnackBar(content: Text("Hasło ustawione")));
              },
              child: Text("START"),
            ),
          ],
        ),
      ),
    );
  }
}
