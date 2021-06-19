import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/reducers/members_reducer.dart';
import 'package:knesset_app/reducers/vote_reducer.dart';

class AppState {
  final List<KnessetMember> members;
  final Vote vote;
  AppState(this.members, this.vote);
}

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(membersReducer(state.members, action), voteReducer(state.vote, action));
}
