import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/services/mk_data_service.dart';
import 'package:mobx/mobx.dart';

// Include generated file
part 'members_store.g.dart';

// This is the class used by rest of your codebase
class MembersStore = _MembersStore with _$MembersStore;

// The store-class
abstract class _MembersStore with Store {
  @observable
  List<KnessetMember> members = [];

  @action
  Future<void> load() async {
    members = (await MkDataService().getMembers()).toList();
  }
}
