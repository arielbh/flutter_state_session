import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knesset_app/models/app_state.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/viewModels/totals_view_model.dart';

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
    return StoreConnector<AppState, TotalsViewModel>(
        converter: (store) => TotalsViewModel(store.state.vote),
        builder: (context, viewModel) => Column(
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
                      _totalCounter(viewModel.vote, VoteOptions.favor, theme),
                      SizedBox(width: 8.0),
                      _totalCounter(viewModel.vote, VoteOptions.abstain, theme),
                      SizedBox(width: 8.0),
                      _totalCounter(viewModel.vote, VoteOptions.oppose, theme),
                    ],
                  ),
                ),
                Divider()
              ],
            ));
  }
}
