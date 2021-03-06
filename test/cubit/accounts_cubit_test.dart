import 'package:Safer/data/data_providers/SQLprovider.dart';
import 'package:Safer/data/entities/account_data_entity.dart';
import 'package:Safer/data/repositories/accounts_repository_impl.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:Safer/logic/cubit/all_accounts/accounts_cubit.dart';
import 'package:test/test.dart';

void main() {
  group("AccountsCubit", () {
    late AccountsCubit accountsCubit;

    setUp(() async {
      await SQLprovider().initDB();
      AccountsRepositoryImlp accountsRepository =
          AccountsRepositoryImlp(sqlProvider: SQLprovider());
      accountsCubit = AccountsCubit(accountsRepository: accountsRepository);
    });

    tearDown(() {
      accountsCubit.close();
    });

    var testAddAcc = AccountDataEntity(accountName: "Acc1");
    blocTest<AccountsCubit, AccountsState>('Adding account "Acc1"',
        build: () => accountsCubit,
        act: (cubit) => cubit.addAccount(accountData: testAddAcc),
        expect: () => [
              AccountsLoaded(accountDataList: [testAddAcc])
            ]);
  });
}
