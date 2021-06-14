import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';

class VoteTotalsWidget extends StatefulWidget {
  final Map<KnessetMember, Vote> votes;

  VoteTotalsWidget({Key? key, required this.votes}) : super(key: key);

  @override
  _VoteTotalsWidgetState createState() => _VoteTotalsWidgetState();
}

class _VoteTotalsWidgetState extends State<VoteTotalsWidget> {
  Widget _totalCounter(VoteOptions vote, ThemeData theme) => Container(
        padding: const EdgeInsets.all(8.0),
        color: vote.color,
        child: Text(
          widget.votes.values.where((element) => element.result == vote).length.toString(),
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
          child: Row(
            children: [
              Text(
                "Current Totals:",
                style: theme.textTheme.headline5,
              ),
              SizedBox(width: 8.0),
              _totalCounter(VoteOptions.favor, theme),
              SizedBox(width: 8.0),
              _totalCounter(VoteOptions.abstain, theme),
              SizedBox(width: 8.0),
              _totalCounter(VoteOptions.oppose, theme),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
