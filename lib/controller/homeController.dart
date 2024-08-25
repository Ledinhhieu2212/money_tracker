import 'package:get/get.dart'; 
import 'package:money_tracker/model/transaction.dart';
import 'package:money_tracker/model/user.dart';
import 'package:money_tracker/model/wallet.dart';
import 'package:money_tracker/services/share_preference.dart';
import 'package:money_tracker/services/transaction_service.dart';
import 'package:money_tracker/services/wallet_service.dart';

class HomeController extends GetxController {
  var price = 0.obs;
  var idUser = 0.obs;
  var username = ''.obs;
  var wallets = <Wallet>[].obs; 
  var transactions = <Transaction>[].obs;
  var incomePrice = 0.obs;
  var spendingPrice = 0.obs;

  late TransactionService service;
  late WalletService walletService; 
  var expandedIndexes = <int>[].obs;
  @override
  void onInit() {
    super.onInit();
    initSate();
  }

  Future<void> getIDUser() async {
  UserPreference userPreference = UserPreference();
  User user = await userPreference.getUser();
    idUser.value =  user.id;
    username.value =  user.username;

  }

  Future<void> getTransactions() async {
    await getIDUser();
    service = TransactionService(await getDatabase());
    incomePrice.value =
        await service.totalPriceType(userId: idUser.value, typePrice: 1);
    spendingPrice.value =
        await service.totalPriceType(userId: idUser.value, typePrice: 0);
    transactions.value = await service.searchOfUser(userId: idUser.value);
  }

  Future<void> getWallets() async {
    await getIDUser();
    walletService = WalletService(await getDatabaseWallet());
    wallets.value = await walletService.searchWallets(idUser.value);
   calculateTotalPrice();
  }

  Future<void> getUser() async {
    await getIDUser();
    walletService = WalletService(await getDatabaseWallet());
    wallets.value = await walletService.searchWallets(idUser.value);
    for (final t in wallets) {
      price.value += t.total;
    }
  }

  void calculateTotalPrice() {
    price.value = wallets.fold(0, (sum, wallet) => sum + wallet.total);
  }
  List<Transaction> getTransactionsOfWallet({
    required String idWallet,
    required List<Transaction> transactions,
  }) {
    return transactions.where((t) => t.id_wallet == idWallet).toList();
  }


  void initSate() async {
    await getWallets();
    await getTransactions();
  }

  void toggleExpanded(int index) {
    if (expandedIndexes.contains(index)) {
      expandedIndexes.remove(index); // Nếu ví đã mở rộng thì thu hẹp
    } else {
      expandedIndexes.add(index); // Mở rộng ví mới
    }
  }

  
  bool getTypeTransaction(int type) => type == 1;
  // Phương thức để làm mới dữ liệu ví
  Future<void> refreshWallets() async {
    await getWallets();
  }

  // Phương thức để làm mới dữ liệu giao dịch
  Future<void> refreshTransactions() async {
    await getTransactions();
  }
}
