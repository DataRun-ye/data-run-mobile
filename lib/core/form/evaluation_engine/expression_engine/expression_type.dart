enum ExpressionType {
  Validation(1000),
  Calculation(2000),
  // visibility changes the value just like `Calculation` resulting
  // in considering the field value = null or 0. or based on strategy for
  // deciding whether to cascade to this change to dependents or not
  Visibility(2000);

  const ExpressionType(this.priority);

  final int priority;
}
