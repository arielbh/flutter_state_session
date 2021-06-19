import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:knesset_app/blocs/vote_bloc.dart';
import 'package:knesset_app/blocs/voting_bloc.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/views/mk_vote_widget.dart';

class MkListWidget extends StatelessWidget {
  final List<KnessetMember> members;
  const MkListWidget({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<VoteBloc, VoteState>(
        builder: (context, state) => ListView.builder(
            itemCount: members.length,
            itemBuilder: (BuildContext context, int index) {
              final member = members[index];
              final name = member.name;
              final voteOption = state.vote.votes[member];

              return Column(
                children: [
                  ListTile(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return BlocProvider(
                        create: (context) => VotingBloc(member: member, voteBloc: context.read<VoteBloc>()),
                        child: MkVoteWidget(member: member),
                      );
                    })),
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
                  new Divider(),
                ],
              );
            }));
  }
}
