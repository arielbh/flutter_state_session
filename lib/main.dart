import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/stores/members_store.dart';
import 'package:knesset_app/stores/vote_store.dart';
import 'package:knesset_app/views/mk_list_widget.dart';
import 'package:knesset_app/views/vote_totals_widget.dart';

final membersStore = MembersStore();
final voteStore = VoteStore();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    membersStore.load();
    return Observer(
      builder: (_) => Scaffold(
          appBar: MyAppBar(),
          body: membersStore.members.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    VoteTotalsWidget(),
                    Expanded(
                      child: MkListWidget(
                        members: membersStore.members,
                      ),
                    ),
                  ],
                )),
    );
  }
}
