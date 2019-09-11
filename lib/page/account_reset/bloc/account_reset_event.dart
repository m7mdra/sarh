class AccountResetEvent{}

class ResetAccount extends AccountResetEvent{
  final String phoneNumber;

  ResetAccount(this.phoneNumber);
}
