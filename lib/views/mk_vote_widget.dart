import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:provider/provider.dart';

class MkVoteWidget extends StatefulWidget {
  final KnessetMember member;
  MkVoteWidget({Key? key, required this.member}) : super(key: key);

  @override
  _MkVoteWidgetState createState() => _MkVoteWidgetState();
}

class _MkVoteWidgetState extends State<MkVoteWidget> {
  var _secondsToVote = 6;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsToVote == 0) {
        _onVote(context, VoteOptions.abstain);
        return;
      }
      setState(() {
        _secondsToVote--;
      });
    });
  }

  Widget _createVoteButton(BuildContext context, VoteOptions vote) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          child: Text(vote.display),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(vote.color)),
          onPressed: () => _onVote(context, vote)));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        _onVote(context, VoteOptions.abstain);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: MyAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "${widget.member.name} Votes",
                style: theme.textTheme.headline3,
              ),
            ),
            Text(
              "Seconds to Vote: $_secondsToVote",
              style: theme.textTheme.headline5,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _createVoteButton(context, VoteOptions.favor),
              _createVoteButton(context, VoteOptions.abstain),
              _createVoteButton(context, VoteOptions.oppose)
            ])
          ],
        ),
      ),
    );
  }

  void _onVote(BuildContext context, VoteOptions vote) {
    _timer.cancel();
    context.read<Vote>().addVote(widget.member, vote);
    Navigator.pop(context);
  }
}
