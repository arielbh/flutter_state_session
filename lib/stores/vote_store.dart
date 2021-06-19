import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'vote_store.g.dart';

// This is the class used by rest of your codebase
class VoteStore = _VoteStore with _$VoteStore;

// The store-class
abstract class _VoteStore with Store {
  @observable
  Vote vote = Vote();

  @action
  void addVote(KnessetMember member, VoteOptions voteOption) {
    vote.addVote(member, voteOption);
  }
}
