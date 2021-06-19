import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:meta/meta.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  VoteBloc() : super(VoteState(Vote({})));

  @override
  Stream<VoteState> mapEventToState(VoteEvent event) async* {
    if (event is OnVoteEvent) {
      state.vote.addVote(event.member, event.voteOption);
      // Create new Vote
      yield VoteState(Vote(state.vote.votes));
    }
  }
}

@immutable
abstract class VoteEvent {}

class OnVoteEvent extends VoteEvent {
  final VoteOptions voteOption;
  final KnessetMember member;
  OnVoteEvent(this.member, this.voteOption);
}

@immutable
class VoteState {
  final Vote vote;

  VoteState(this.vote);
}
