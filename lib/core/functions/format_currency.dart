String formatCurrency(double? number) {
  if (number == null) {
    return "\$0";
  } else {
    return " \$${number.toStringAsFixed(2)}";
  }
}
