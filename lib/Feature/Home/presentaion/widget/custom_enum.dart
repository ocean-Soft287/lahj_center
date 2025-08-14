 enum ReportReason {
  Abuse(1), 
  InappropriateContent(2); 
  final int value;
  const ReportReason(this.value);
}
