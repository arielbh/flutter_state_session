import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/blocs/voting_bloc.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:provider/provider.dart';

class MkVoteWidget extends StatelessWidget {
  final KnessetMember member;
  MkVoteWidget({Key? key, required this.member}) : super(key: key);

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
                "${member.name} Votes",
                style: theme.textTheme.headline3,
              ),
            ),
            BlocBuilder<VotingBloc, VotingState>(
              builder: (context, state) {
                if (state.secondsToVote == 0)
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    _onVote(context, VoteOptions.abstain);
                  });
                return Text(
                  "Seconds to Vote: ${state.secondsToVote}",
                  style: theme.textTheme.headline5,
                );
              },
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
    context.read<VotingBloc>().add(MemberVotedEvent(vote));
    Navigator.pop(context);
  }
}
