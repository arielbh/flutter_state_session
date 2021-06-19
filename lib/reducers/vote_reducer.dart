import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';

Vote voteReducer(Vote state, dynamic action) {
  if (action is Map<KnessetMember, VoteOptions>) {
    final map = state.votes;
    map.addAll(action);
    return Vote(map);
  }
  return state;
}
