import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:knesset_app/blocs/vote_bloc.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:meta/meta.dart';

class VotingBloc extends Bloc<VotingEvent, VotingState> {
  final VoteBloc voteBloc;
  final KnessetMember member;
  late Timer _timer;

  VotingBloc({required this.voteBloc, required this.member}) : super(VotingInitial()) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(TimerEvent());
    });
  }

  @override
  Stream<VotingState> mapEventToState(VotingEvent event) async* {
    if (event is TimerEvent) {
      if (state.secondsToVote == 1) {
        _timer.cancel();
      }
      yield TimerVoteState(state.secondsToVote - 1);
    }
    if (event is MemberVotedEvent) {
      voteBloc.add(OnVoteEvent(member, event.voteOption));
    }
  }
}

@immutable
abstract class VotingEvent {}

class MemberVotedEvent extends VotingEvent {
  final VoteOptions voteOption;

  MemberVotedEvent(this.voteOption);
}

class TimerEvent extends VotingEvent {}

@immutable
abstract class VotingState {
  final int secondsToVote;

  VotingState(this.secondsToVote);
}

class VotingInitial extends VotingState {
  VotingInitial() : super(6);
}

class TimerVoteState extends VotingState {
  TimerVoteState(int secondsToVote) : super(secondsToVote);
}
