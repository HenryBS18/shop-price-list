String formatCurrency(int amount) {
  String formattedAmount = 'Rp ';
  String amountString = amount.toString();

  int length = amountString.length;

  for (int i = 0; i < length; i++) {
    if ((length - i) % 3 == 0 && i != 0) {
      formattedAmount += '.';
    }
    formattedAmount += amountString[i];
  }

  return formattedAmount;
}
