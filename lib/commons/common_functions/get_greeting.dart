String getGreeting() {
  final currentTime = DateTime.now();
  final hour = currentTime.hour;

  if (hour >= 0 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}