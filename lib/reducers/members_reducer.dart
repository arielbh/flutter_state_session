import 'package:knesset_app/models/app_state.dart';
import 'package:knesset_app/models/mk.dart';
import 'package:knesset_app/services/mk_data_service.dart';
import 'package:redux/redux.dart';

List<KnessetMember> membersReducer(List<KnessetMember> state, dynamic action) {
  if (action is List<KnessetMember>) {
    return action;
  }
  return state;
}

void loadAction(Store<AppState> store) async {
  final list = (await MkDataService().getMembers()).toList();
  store.dispatch(list);
}
