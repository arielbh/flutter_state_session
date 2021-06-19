import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knesset_app/blocs/vote_bloc.dart';
import 'package:knesset_app/models/vote.dart';

class VoteTotalsWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<VoteBloc, VoteState>(
              builder: (context, state) => Row(
                    children: [
                      Text(
                        "Current Totals:",
                        style: theme.textTheme.headline5,
                      ),
                      SizedBox(width: 8.0),
                      _totalCounter(state.vote, VoteOptions.favor, theme),
                      SizedBox(width: 8.0),
                      _totalCounter(state.vote, VoteOptions.abstain, theme),
                      SizedBox(width: 8.0),
                      _totalCounter(state.vote, VoteOptions.oppose, theme),
                    ],
                  )),
        ),
        Divider()
      ],
    );
  }
}
