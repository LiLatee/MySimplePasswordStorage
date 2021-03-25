import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysimplepasswordstorage/models/DataProvider.dart';
import 'package:mysimplepasswordstorage/models/account_data_entity.dart';
import 'package:provider/provider.dart';

import '../../../components/modified_flutter_widgets/expansion_panel.dart' as epn;
import '../../../utils/AppConstants.dart' as MyConstants;
import 'account_tile/expanded_part/account_data_expanded_part.dart';
import 'account_tile/header.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<AccountDataEntity>>(
      stream: DataProvider.accountsStream,
      builder: (context, AsyncSnapshot<List<AccountDataEntity>> snapshot) {
        if (snapshot.hasData) {
          return epn.ExpansionPanelList.radio(
            expandedHeaderPadding:
                EdgeInsets.only(left: MyConstants.defaultPadding * 3),
            children: snapshot.data!
                .map((e) => buildExpansionPanel(accountDataEntity: e))
                .toList(),
          );
        } else {
          return epn.ExpansionPanelList.radio(
            expandedHeaderPadding:
                EdgeInsets.only(left: MyConstants.defaultPadding * 3),
            children: [],
          );
        }
      },
    );

  }

  epn.ExpansionPanelRadio buildExpansionPanel(
      {required AccountDataEntity accountDataEntity}) {
    return epn.ExpansionPanelRadio(
      canTapOnHeader: true,
      value: accountDataEntity.uuid!,
      headerBuilder: (BuildContext context, bool isExpanded) {
        // return Text("${accountDataEntity.accountName}");
        return Provider.value(
          value: accountDataEntity,
          child: AccountTileHeader(),
        );
      },
      body: Provider.value(
        value: accountDataEntity,
        child: AccountDataExpandedPart(),
      ),
    );
  }
}
