enum ConflictStrategy {
  serverWins,
  clientWins,
  merge,
  timestamp,
}

class SyncConfig {
  final ConflictStrategy? conflictStrategy;
  final bool deltaOnly;
  final DateTime? lastSync;
  final Map<String, dynamic>? params;

  SyncConfig(
      {this.conflictStrategy,
      this.deltaOnly = false,
      this.lastSync,
      this.params});
}
