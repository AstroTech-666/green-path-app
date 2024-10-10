import 'package:flutter/material.dart';
import 'package:green_path/personal_goals.dart'; // Import the PersonalGoals class

class PersonalGoalsScreen extends StatefulWidget {
  const PersonalGoalsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonalGoalsScreenState createState() => _PersonalGoalsScreenState();
}

class _PersonalGoalsScreenState extends State<PersonalGoalsScreen> {
  final PersonalGoals myGoals = PersonalGoals('My Personal Goals', []);
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _targetDateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController(); // Controller for notes
  String _status = 'Not Started';
  String _category = 'Sustainability'; // Updated to include sustainability
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // Example milestones for badges
  int completedGoalsCount = 0; 

  void _addGoal() {
    if (_descriptionController.text.isNotEmpty && _targetDateController.text.isNotEmpty) {
      final newGoal = Goal(
        _descriptionController.text,
        _targetDateController.text,
        _status,
        notes: _notesController.text, // Add notes to the goal
        category: _category, // Add category to the goal
        impact: _getEnvironmentalImpact(_descriptionController.text), // Add environmental impact
      );
      myGoals.addGoal(newGoal);
      _listKey.currentState?.insertItem(myGoals.goals.length - 1); // Animate adding item
      _descriptionController.clear();
      _targetDateController.clear();
      _notesController.clear(); // Clear notes
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Goal added! 🎉')),
      );
      _checkBadges(); // Check if any badges are earned
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
    }
  }

  String _getEnvironmentalImpact(String description) {
    // Simple impact generation based on description
    if (description.toLowerCase().contains('reduce waste')) {
      return 'This goal helps in minimizing landfill waste!';
    } else if (description.toLowerCase().contains('plant trees')) {
      return 'Planting trees improves air quality and provides habitats.';
    } else if (description.toLowerCase().contains('save energy')) {
      return 'This goal will contribute to reduced carbon emissions.';
    }
    return 'No specific impact noted.';
  }

  void _updateProgress(Goal goal, String newStatus) {
    setState(() {
      myGoals.updateProgress(goal, newStatus);
      if (newStatus == 'Completed') {
        completedGoalsCount++;
      }
    });
  }

  void _removeGoal(int index) {
    final removedGoal = myGoals.goals[index];
    myGoals.removeGoal(removedGoal);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: ListTile(
            title: Text(removedGoal.description),
            subtitle: Text('Due: ${removedGoal.targetDate}'),
          ),
        );
      },
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Goal removed! 🚮')),
    );
  }

  double _calculateProgress() {
    int completedGoals = myGoals.goals.where((goal) => goal.progress == 'Completed').length;
    return myGoals.goals.isNotEmpty ? completedGoals / myGoals.goals.length : 0.0;
  }

  void _checkBadges() {
    // Logic to award badges
    if (completedGoalsCount >= 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🎖 You earned a badge for completing 5 goals!')),
      );
    }
    // Additional badges can be checked here
  }

  @override
  Widget build(BuildContext context) {
    double progress = _calculateProgress();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Goals 🏆'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(value: progress, minHeight: 20),
            const SizedBox(height: 10),
            Text(
              '${(progress * 100).toStringAsFixed(0)}% Goals Completed',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Goal Description',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _targetDateController,
              decoration: const InputDecoration(
                labelText: 'Target Date (YYYY-MM-DD)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _category,
              items: <String>[
                'Sustainability',
                'Reduce Waste',
                'Energy Saving',
                'Tree Planting',
                'Education',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _category = newValue!;
                });
              },
              isExpanded: true,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Notes/Comments',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.comment),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _status,
              items: <String>['Not Started', 'In Progress', 'Completed']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _status = newValue!;
                });
              },
              isExpanded: true,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addGoal,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Add Goal'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AnimatedList(
                key: _listKey,
                initialItemCount: myGoals.goals.length,
                itemBuilder: (context, index, animation) {
                  final goal = myGoals.goals[index];
                  return SizeTransition(
                    sizeFactor: animation,
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(goal.description, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Due: ${goal.targetDate}'),
                            Text('Status: ${goal.progress}'),
                            Text('Category: ${goal.category}'), // Display category
                            Text('Notes: ${goal.notes}'), // Display notes
                            Text('Impact: ${goal.impact}'), // Display impact
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check, color: Colors.green),
                              onPressed: () => _updateProgress(goal, 'Completed'),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeGoal(index),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share, color: Colors.blue),
                              onPressed: () {
                                // Share functionality (just a placeholder)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Sharing goal: ${goal.description}')),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text('User Feedback'),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Feedback submitted: $value')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
