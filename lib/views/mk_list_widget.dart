import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/providers/providers.dart';
import 'package:knesset_app/views/mk_vote_widget.dart';

class MkListWidget extends ConsumerWidget {
  final List<KnessetMember> members;

  const MkListWidget({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final theme = Theme.of(context);
    final vote = watch(voteProvider);

    return ListView.builder(
        itemCount: members.length,
        itemBuilder: (BuildContext context, int index) {
          final member = members[index];
          final name = member.name;
          final voteOption = vote.votes[member];

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
  }
}
