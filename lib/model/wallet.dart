class Wallet {
  final int? ma_so_vi;
  final int? ma_nguoi_dung;
  final int? money_price;
  final String? account_name;
  final String? icon;
  final String? currency;

  const Wallet({
    this.ma_so_vi,
    this.ma_nguoi_dung,
    this.money_price,
    this.account_name,
    this.icon,
    this.currency,
  });

  Map<String, Object?> toMap() {
    return {
      'ma_so_vi': ma_so_vi,
      'ma_nguoi_dung': ma_nguoi_dung,
      'money_price': money_price,
    };
  }

  @override
  String toString() {
    return 'Wallet{ma_so_vi: $ma_so_vi, ma_nguoi_dung: $ma_nguoi_dung, money_price: $money_price}';
  }
}
