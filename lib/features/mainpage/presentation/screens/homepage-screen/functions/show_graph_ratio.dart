double showGraphRatio({
  required double? numerator,
  required double? denominator,
}) {
  if (denominator == null || numerator == null || denominator == 0 || numerator == 0) {
    return 0.01;
  } else {
    double result = numerator / denominator;
    return result > 0.25 ? 0.25 : result;
  }
}
