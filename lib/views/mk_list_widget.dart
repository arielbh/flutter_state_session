import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knesset_app/models/app_state.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/viewModels/list_view_model.dart';
import 'package:knesset_app/views/mk_vote_widget.dart';

class MkListWidget extends StatelessWidget {
  const MkListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StoreConnector<AppState, ListViewModel>(
        converter: (store) => ListViewModel(store.state.members, store.state.vote),
        builder: (context, viewModel) => ListView.builder(
            itemCount: viewModel.members.length,
            itemBuilder: (BuildContext context, int index) {
              final member = viewModel.members[index];
              final name = member.name;
              final voteOption = viewModel.vote.votes[member];

              return Column(
                children: [
                  ListTile(
                    onTap: () =>
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MkVoteWidget(member: member))),
                    leading: CircleAvatar(
                      child: new Icon(Icons.account_box),
                    ),
                    title: Text(name, style: theme.textTheme.headline6),
                    trailing: voteOption != null
                        ? Container(
                            width: 80.0,
                            decoration:
                                BoxDecoration(color: voteOption.color, borderRadius: BorderRadius.circular(8.0)),
                            padding: const EdgeInsets.all(4.0),
                            child: Text(voteOption.display,
                                textAlign: TextAlign.center,
                                style: theme.textTheme.subtitle1!.copyWith(color: Colors.white)),
                          )
                        : null,
                  ),
                  Divider(),
                ],
              );
            }));
  }
}
