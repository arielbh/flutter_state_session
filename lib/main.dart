import 'package:flutter/material.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/services/mk_data_service.dart';
import 'package:knesset_app/views/mk_list_widget.dart';
import 'package:knesset_app/views/mk_vote_widget.dart';
import 'package:knesset_app/views/vote_totals_widget.dart';

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<KnessetMember> _members = [];
  Vote _vote = Vote({});
  @override
  void initState() {
    super.initState();
    MkDataService().getMembers().then((value) => setState(() => _members = value.toList()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(),
        body: _members.isEmpty
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  VoteTotalsWidget(vote: _vote),
                  Expanded(
                    child: MkListWidget(
                        members: _members,
                        vote: _vote,
                        onSelectMember: (member) async {
                          final vote = await Navigator.push<VoteOptions>(context, MaterialPageRoute(builder: (context) {
                            return MkVoteWidget(member: member);
                          }));
                          if (vote != null) {
                            setState(() {
                              _vote.addVote(member, vote);
                            });
                          }
                        }),
                  ),
                ],
              ));
  }
}
