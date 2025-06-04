// lib/data/live_session_status.dart

/// Represents the status of a live session.
enum LiveSessionStatus {
  upcoming,
  ongoing,
  completed,
  cancelled,
}

// Helper function to get a display string for the status
String getLiveSessionStatusText(LiveSessionStatus status) {
  switch (status) {
    case LiveSessionStatus.upcoming:
      return 'Upcoming';
    case LiveSessionStatus.ongoing:
      return 'Ongoing';
    case LiveSessionStatus.completed:
      return 'Completed';
    case LiveSessionStatus.cancelled:
      return 'Cancelled';
    default:
      return 'Unknown';
  }
}
