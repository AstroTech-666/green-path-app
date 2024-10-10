class Goal {
  // Define private fields
  final String _description;
  final String _targetDate;
  String _progress;
  final String _notes; // Added notes
  final String _category; // Added category
  final String _impact; // Added impact

  // Constructor with required fields
  Goal(
    this._description,
    this._targetDate,
    this._progress, {
    required String notes,
    required String category,
    required String impact,
  })  : _notes = notes,
        _category = category,
        _impact = impact;

  // Getters for accessing private fields
  String get description => _description;
  String get targetDate => _targetDate;
  String get progress => _progress;
  String get notes => _notes;
  String get category => _category;
  String get impact => _impact;

  // Method to update progress
  void updateProgress(String newStatus) {
    _progress = newStatus;
  }

  // Override toString for better representation
  @override
  String toString() {
    return 'Goal: $_description, Due: $_targetDate, Status: $_progress, Notes: $_notes, Category: $_category, Impact: $_impact';
  }
}

class PersonalGoals {
  String title;
  List<Goal> goals;

  PersonalGoals(this.title, this.goals);

  void addGoal(Goal goal) {
    goals.add(goal);
  }

  void updateProgress(Goal goal, String newStatus) {
    goal.updateProgress(newStatus); // Use the method from Goal class
  }

  void removeGoal(Goal goal) {
    goals.remove(goal);
  }

  @override
  String toString() {
    return 'PersonalGoals: $title, Goals Count: ${goals.length}';
  }
}
