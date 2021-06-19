import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:knesset_app/services/mk_data_service.dart';
import 'package:riverpod/riverpod.dart';

final membersProvider = FutureProvider((ref) async => await MkDataService().getMembers());

final voteProvider = StateNotifierProvider<VoteProvider, Vote>((ref) {
  return VoteProvider();
});

class VoteProvider extends StateNotifier<Vote> {
  VoteProvider() : super(Vote({}));

  void addVote(KnessetMember member, VoteOptions voteOption) {
    state.addVote(member, voteOption);
    state = Vote(state.votes);
  }
}
