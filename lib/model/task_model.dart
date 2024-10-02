class Task {
  final String taskName;
  double progress; // Expecting this to be a double
  final String date;
  final String timeStart;
  final String timeEnd;

  Task({
    required this.taskName,
    required this.progress,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      taskName: json['taskName'] ?? 'Unnamed Task', // Default value
      progress: (json['progress'] != null)
          ? json['progress'].toDouble()
          : 0.0, // Default to 0.0
      date: json['date'] ?? DateTime.now().toString(), // Default to now
      timeStart: json['timeStart'] ?? '00:00', // Default value
      timeEnd: json['timeEnd'] ?? '23:59', // Default value
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'progress': progress,
      'date': date,
      'timeStart': timeStart,
      'timeEnd': timeEnd,
    };
  }
}
