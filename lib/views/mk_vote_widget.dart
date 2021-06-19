import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/main.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/stores/voting_store.dart';

class MkVoteWidget extends StatelessWidget {
  final VotingStore votingStore;
  MkVoteWidget({Key? key, required this.votingStore}) : super(key: key) {
    votingStore.startTimer();
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
                "${votingStore.member.name} Votes",
                style: theme.textTheme.headline3,
              ),
            ),
            Observer(builder: (_) {
              if (votingStore.secondsToVote == 0) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  _onVote(context, VoteOptions.abstain);
                });
              }
              return Text(
                "Seconds to Vote: ${votingStore.secondsToVote}",
                style: theme.textTheme.headline5,
              );
            }),
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
    voteStore.addVote(votingStore.member, vote);
    Navigator.pop(context);
  }
}
