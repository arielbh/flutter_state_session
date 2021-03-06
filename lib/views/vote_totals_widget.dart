import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/providers/providers.dart';

class VoteTotalsWidget extends ConsumerWidget {
  VoteTotalsWidget({Key? key}) : super(key: key);

  Widget _totalCounter(Vote vote, VoteOptions voteOption, ThemeData theme) => Container(
        padding: const EdgeInsets.all(8.0),
        color: voteOption.color,
        child: Text(
          vote.votes.values.where((option) => option == voteOption).length.toString(),
          style: theme.textTheme.headline5!.copyWith(color: Colors.white),
        ),
      );

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final vote = watch(voteProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                "Current Totals:",
                style: theme.textTheme.headline5,
              ),
              SizedBox(width: 8.0),
              _totalCounter(vote, VoteOptions.favor, theme),
              SizedBox(width: 8.0),
              _totalCounter(vote, VoteOptions.abstain, theme),
              SizedBox(width: 8.0),
              _totalCounter(vote, VoteOptions.oppose, theme),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
