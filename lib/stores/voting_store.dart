import 'dart:async';

import 'package:knesset_app/models/mk.dart';
import 'package:mobx/mobx.dart';

part 'voting_store.g.dart';

class VotingStore = _VotingStore with _$VotingStore;

abstract class _VotingStore with Store {
  final KnessetMember member;
  late Timer _timer;
  _VotingStore(this.member);

  @observable
  int secondsToVote = 6;

  @action
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      secondsToVote--;
      if (secondsToVote == 0) {
        _timer.cancel();
      }
    });
  }
}
