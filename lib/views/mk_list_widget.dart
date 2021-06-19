import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';

class MkListWidget extends StatefulWidget {
  final List<KnessetMember> members;
  final Vote vote;
  final Function(KnessetMember) onSelectMember;
  const MkListWidget({
    Key? key,
    required this.members,
    required this.vote,
    required this.onSelectMember,
  }) : super(key: key);

  @override
  _MkListWidgetState createState() => _MkListWidgetState();
}

class _MkListWidgetState extends State<MkListWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
        itemCount: widget.members.length,
        itemBuilder: (BuildContext context, int index) {
          final member = widget.members[index];
          final name = member.name;
          final voteOption = widget.vote.votes[member];

          return Column(
            children: [
              ListTile(
                onTap: () => widget.onSelectMember(widget.members[index]),
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
