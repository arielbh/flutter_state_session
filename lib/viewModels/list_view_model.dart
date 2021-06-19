import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/models/vote.dart';

class ListViewModel {
  final List<KnessetMember> members;
  final Vote vote;
  ListViewModel(this.members, this.vote);
}
