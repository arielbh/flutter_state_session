import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:knesset_app/app_bar.dart';
import 'package:knesset_app/models/app_state.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:redux/redux.dart';

class MkVoteWidget extends StatefulWidget {
  final KnessetMember member;
  MkVoteWidget({Key? key, required this.member}) : super(key: key);

  @override
  _MkVoteWidgetState createState() => _MkVoteWidgetState();
}

class _MkVoteWidgetState extends State<MkVoteWidget> {
  var _secondsToVote = 6;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsToVote == 0) {
        final store = StoreProvider.of<AppState>(context);

        _onVote(store, VoteOptions.abstain);
        return;
      }
      setState(() {
        _secondsToVote--;
      });
    });
  }

  Widget _createVoteButton(Store<AppState> store, VoteOptions vote) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          child: Text(vote.display),
          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(vote.color)),
          onPressed: () => _onVote(store, vote)));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final store = StoreProvider.of<AppState>(context);

    return WillPopScope(
      onWillPop: () async {
        _onVote(store, VoteOptions.abstain);
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
                "${widget.member.name} Votes",
                style: theme.textTheme.headline3,
              ),
            ),
            Text(
              "Seconds to Vote: $_secondsToVote",
              style: theme.textTheme.headline5,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _createVoteButton(store, VoteOptions.favor),
              _createVoteButton(store, VoteOptions.abstain),
              _createVoteButton(store, VoteOptions.oppose)
            ])
          ],
        ),
      ),
    );
  }

  void _onVote(Store<AppState> store, VoteOptions vote) {
    _timer.cancel();
    store.dispatch(Map<KnessetMember, VoteOptions>()..[widget.member] = vote);
    Navigator.pop(context);
  }
}
