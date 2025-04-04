enum SyncStatus {
  TO_POST,
  TO_UPDATE,
  SYNCED,
  ERROR;
  // WARNING,
  // UPLOADING,
  // SYNCED_VIA_SMS,
  // SENT_VIA_SMS;

  bool isToPost() {
    return this == SyncStatus.TO_POST;
  }

  bool isToUpdate() {
    return this == SyncStatus.TO_UPDATE;
  }

  bool isSynced() {
    return this == SyncStatus.SYNCED;
  }

  static List<SyncStatus> get uploadableStatesIncludingError => <SyncStatus>[
        TO_POST,
        TO_UPDATE,
        // SENT_VIA_SMS,
        // SYNCED_VIA_SMS,
        // UPLOADING,
        ERROR,
        // WARNING
      ];
}
