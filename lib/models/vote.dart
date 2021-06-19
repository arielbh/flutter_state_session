import 'package:flutter/material.dart';
import 'package:knesset_app/models/mk.dart';

enum VoteOptions { favor, oppose, abstain }

class Vote {
  final Map<KnessetMember, VoteOptions> votes;

  Vote(this.votes);

  void addVote(KnessetMember member, VoteOptions vote) => votes[member] = vote;
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
