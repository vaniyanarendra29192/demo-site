/// Result of a conflict check — carries an optional error message.
class ConflictResult {
  const ConflictResult._({this.message});

  /// No conflict detected.
  const ConflictResult.none() : this._();

  /// Conflict detected — [message] is non-null.
  const ConflictResult.conflict(String message) : this._(message: message);

  final String? message;

  bool get hasConflict => message != null;
}
