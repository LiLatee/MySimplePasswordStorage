import 'package:mysimplepasswordstorage/models/account_data.dart';
import 'package:rxdart/rxdart.dart';

class AllAccountsBloc {
  List<AccountData> accounts = [];
  BehaviorSubject<List<AccountData>> _behaviorSubject;

  AllAccountsBloc({
    accounts,
  }) {
    this.accounts = accounts;
    _behaviorSubject = BehaviorSubject.seeded(this.accounts);
  }

  Stream<List<AccountData>> get accountsObservable => _behaviorSubject.stream;

  void addAccount({AccountData accountData}) {
    accounts.add(accountData);
    _behaviorSubject.sink.add(accounts);
  }
}
