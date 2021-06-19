import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:knesset_app/main.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/stores/voting_store.dart';
import 'package:knesset_app/views/mk_vote_widget.dart';

class MkListWidget extends StatelessWidget {
  final List<KnessetMember> members;

  const MkListWidget({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
        itemCount: members.length,
        itemBuilder: (BuildContext context, int index) {
          return Observer(builder: (_) {
            final member = members[index];
            final name = member.name;
            final voteOption = voteStore.vote.votes[member];
            final votingStore = VotingStore(member);

            return Column(
              children: [
                ListTile(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => MkVoteWidget(votingStore: votingStore))),
                  leading: CircleAvatar(
                    child: new Icon(Icons.account_box),
                  ),
                  title: Text(name, style: theme.textTheme.headline6),
                  trailing: voteOption != null
                      ? Container(
                          width: 80.0,
                          decoration: BoxDecoration(color: voteOption.color, borderRadius: BorderRadius.circular(8.0)),
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
          });
        });
  }
}
