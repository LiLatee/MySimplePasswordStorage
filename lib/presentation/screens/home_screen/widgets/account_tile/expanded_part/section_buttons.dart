import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_simple_password_storage_clean/data/models/account_data_entity.dart';
import 'package:my_simple_password_storage_clean/logic/cubit/single_account_cubit.dart';

import 'package:provider/provider.dart';

import '../../../../../../core/constants/AppConstants.dart' as MyConstants;

import 'account_data_expanded_part.dart';
import 'button_add_field.dart';
import 'button_edit_account.dart';
import 'button_remove_account.dart';
import 'button_save_changes.dart';
import 'button_undo_changes.dart';
import 'button_show_hidden_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionButtons extends StatefulWidget {
  SectionButtons({Key? key}) : super(key: key);

  @override
  _SectionButtonsState createState() => _SectionButtonsState();
}

class _SectionButtonsState extends State<SectionButtons> {
  late AccountDataEntity _accountDataEntity;

  @override
  Widget build(BuildContext context) {
    _accountDataEntity = Provider.of<AccountDataEntity>(context);
    var cubit = BlocProvider.of<SingleAccountCubit>(context);

    return Column(
      children: [
        Divider(
          color: Colors.black,
        ), // TODO?

        cubit.state is SingleAccountStateEditing &&
                _accountDataEntity.isEditButtonPressed
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonSaveChanges(),
                  VerticalDivider(color: Colors.black),
                  ButtonUndoChanges(),
                ],
              )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.all(MyConstants.defaultPadding),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      MyConstants.defaultCircularBorderRadius),
                  color: Theme.of(context).secondaryHeaderColor,
                ), // TODO
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonShowHiddenFields(
                        accountDataEntity: _accountDataEntity),
                    ButtonEditAccount(accountDataEntity: _accountDataEntity),
                    ButtonAddField(
                      accountDataEntity: _accountDataEntity,
                    ),
                    ButtonRemoveAccount(accountDataEntity: _accountDataEntity),
                    // buildAddFieldButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
