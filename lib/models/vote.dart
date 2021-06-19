import 'package:flutter/material.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:mobx/mobx.dart';
part 'vote.g.dart';

enum VoteOptions { favor, oppose, abstain }


class Vote = VoteBase with _$Vote;

abstract class VoteBase with Store {
  @observable
  ObservableMap<KnessetMember, VoteOptions> votes = ObservableMap();

  void addVote(KnessetMember member, VoteOptions vote) {
    votes[member] = vote;
  } 
}

extension VoteOptionsString on VoteOptions {
  String get display {
    switch (this) {
      case VoteOptions.favor:
        return "Favor";
      case VoteOptions.oppose:
        return "Oppose";
      case VoteOptions.abstain:
        return "Abstain";
    }
  }

  MaterialColor get color {
    switch (this) {
      case VoteOptions.favor:
        return Colors.green;
      case VoteOptions.oppose:
        return Colors.red;
      case VoteOptions.abstain:
        return Colors.blue;
    }
  }
}
