import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'package:share_plus/share_plus.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  int _currentCategoryIndex = 0;
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isAnswered = false;
  late ConfettiController _controller;
  final List<int> _scoresHistory = []; // To keep track of scores
  bool _hintUsed = false; // Track if a hint is used
  final List<String> _hints = [
    "This is the correct answer!",
    "Two answers are incorrect.",
    "Many people choose this answer.",
  ];

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _playSound(String soundFile) async {
    await _audioPlayer.play(AssetSource(soundFile));
  }

  void _answerQuestion(int score) {
    setState(() {
      _isAnswered = true;
      _score += score;

      // Play sound and show animations for correct/incorrect answers
      if (score > 0) {
        _playSound('assets/sounds/correct.mp3');
        _showMessage('Great job! Keep it up!', Colors.green);
      } else {
        _playSound('assets/sounds/wrong.mp3');
        _showMessage('Oops! Don\'t give up, try again!', Colors.red);
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isAnswered = false;
        _currentQuestionIndex++;

        if (_currentQuestionIndex >=
            _questions[_currentCategoryIndex]['questions'].length) {
          _currentCategoryIndex++;
          _currentQuestionIndex = 0;
        }

        if (_currentCategoryIndex >= _questions.length) {
          _scoresHistory.add(_score); // Add score to history
          _controller.play(); // Start confetti
        }
      });
    });
  }

  void _resetQuiz() {
    setState(() {
      _currentCategoryIndex = 0;
      _currentQuestionIndex = 0;
      _score = 0;
      _controller.stop();
      _hintUsed = false; // Reset hint used
    });
  }

  void _useHint() {
    if (!_hintUsed) {
      setState(() {
        _hintUsed = true;
        _showMessage(_hints[Random().nextInt(_hints.length)], Colors.blue);
      });
    }
  }

  void _showMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
      duration: const Duration(seconds: 2),
    ));
  }

  void _shareScore() {
    Share.share(
        'I scored $_score points in the Waste Management Quiz! Try it out!');
  }

  @override
  Widget build(BuildContext context) {
    if (_currentCategoryIndex < _questions.length &&
        _currentQuestionIndex <
            _questions[_currentCategoryIndex]['questions'].length) {
      final currentQuestion =
          _questions[_currentCategoryIndex]['questions'][_currentQuestionIndex];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Waste Management Quiz'),
          backgroundColor: Colors.green[700],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: _isAnswered
                ? (_score > 0 ? Colors.green[100] : Colors.red[100])
                : null,
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/${_getCategoryImage()}.jpg'), // Use themed backgrounds
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    currentQuestion['questionText'],
                    style: GoogleFonts.openSans(
                        fontSize: 24,
                        color: const Color.fromARGB(255, 16, 61, 10)),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ...currentQuestion['answers'].map((answer) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0), // Adds space between buttons
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15), // Round the corners
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15), // Padding inside the button
                          backgroundColor:
                              Colors.green[700], // Customize the button color
                        ),
                        onPressed: _isAnswered
                            ? null
                            : () => _answerQuestion(answer['score']),
                        child: Text(
                          answer['text'],
                          style: const TextStyle(
                              fontSize: 18), // Adjust text size if needed
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  Text(
                    'Score: $_score',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 16, 61, 10), fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _shareScore(),
                    child: const Text('Share Your Score!'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => _useHint(),
                    child: const Text('Use Hint'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Waste Management Quiz'),
          backgroundColor: Colors.green[700],
        ),
        body: Stack(
          children: [
            ConfettiWidget(
              confettiController: _controller,
              blastDirection: pi / 2,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.1,
              shouldLoop: true,
              colors: const [
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.yellow,
                Colors.orange,
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quiz Finished! Your score: $_score',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 16, 61, 10),
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _resetQuiz,
                      child: const Text('Retake Quiz'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to more learning resources
                      },
                      child: const Text('Learn More'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Leaderboard:',
                      style: TextStyle(
                        color: Color.fromARGB(255, 16, 61, 10),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ..._scoresHistory.map((score) {
                      return Text(
                        'Score: $score',
                        style: const TextStyle(fontSize: 18),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

// Define themed images based on categories
  String _getCategoryImage() {
    switch (_currentCategoryIndex) {
      case 0:
        return 'recycling_theme'; // Themed background for recycling
      case 1:
        return 'composting_theme'; // Themed background for composting
      case 2:
        return 'e_waste_background'; // New category
      case 3:
        return 'hazardous_theme'; // New category
      default:
        return _questions[_currentCategoryIndex]['imageName'] ??
            'default_image';
    }
  }

  final List<Map<String, dynamic>> _questions = [
    // Place your question data here
    {
      'category': 'Composting',
      'questions': [
        {
          'questionText': 'What is composting?',
          'answers': [
            {'text': 'Burning waste', 'score': 0},
            {'text': 'Decomposing organic materials', 'score': 1},
            {'text': 'Recycling plastics', 'score': 0},
            {'text': 'Throwing waste in landfills', 'score': 0},
          ],
        },
        {
          'questionText': 'Which material is best for composting?',
          'answers': [
            {'text': 'Plastic bags', 'score': 0},
            {'text': 'Food scraps', 'score': 1},
            {'text': 'Glass bottles', 'score': 0},
            {'text': 'Aluminum cans', 'score': 0},
          ],
        },
        {
          'questionText': 'What does composting help reduce?',
          'answers': [
            {'text': 'Air pollution', 'score': 0},
            {'text': 'Landfill waste', 'score': 1},
            {'text': 'Water pollution', 'score': 0},
            {'text': 'None of the above', 'score': 0},
          ],
        },
        // More composting questions...
      ],
    },
    {
      'category': 'E-Waste Management',
      'questions': [
        {
          'questionText': 'What is e-waste?',
          'answers': [
            {'text': 'Electronic waste', 'score': 1},
            {'text': 'Environmental waste', 'score': 0},
            {'text': 'Plastic waste', 'score': 0},
            {'text': 'Hazardous waste', 'score': 0},
          ],
        },
        {
          'questionText': 'How should e-waste be disposed of?',
          'answers': [
            {'text': 'Thrown in the trash', 'score': 0},
            {'text': 'Taken to a recycling center', 'score': 1},
            {'text': 'Burned', 'score': 0},
            {'text': 'Buried in landfill', 'score': 0},
          ],
        },
        {
          'questionText': 'Which of the following is considered e-waste?',
          'answers': [
            {'text': 'Old phones', 'score': 1},
            {'text': 'Glass bottles', 'score': 0},
            {'text': 'Cardboard', 'score': 0},
            {'text': 'Food scraps', 'score': 0},
          ],
        },
        // More e-waste management questions...
      ],
    },
    {
      'category': 'Hazardous Waste',
      'questions': [
        {
          'questionText': 'What is hazardous waste?',
          'answers': [
            {
              'text': 'Waste that is dangerous or potentially harmful',
              'score': 1
            },
            {'text': 'Household waste', 'score': 0},
            {'text': 'Food waste', 'score': 0},
            {'text': 'Recyclable waste', 'score': 0},
          ],
        },
        {
          'questionText': 'How should hazardous waste be disposed of?',
          'answers': [
            {'text': 'In the regular trash', 'score': 0},
            {'text': 'At a hazardous waste facility', 'score': 1},
            {'text': 'Burned', 'score': 0},
            {'text': 'Thrown in landfills', 'score': 0},
          ],
        },
        {
          'questionText': 'Which of the following is hazardous waste?',
          'answers': [
            {'text': 'Batteries', 'score': 1},
            {'text': 'Plastic bottles', 'score': 0},
            {'text': 'Food scraps', 'score': 0},
            {'text': 'Paper products', 'score': 0},
          ],
        },
        // More hazardous waste questions...
      ],
    },
    {
      'category': 'Recycling Guidelines',
      'questions': [
        {
          'questionText': 'Which of the following can be recycled?',
          'answers': [
            {'text': 'Plastic bottles', 'score': 1},
            {'text': 'Food waste', 'score': 0},
            {'text': 'Used tissues', 'score': 0},
            {'text': 'Glass bottles', 'score': 1},
          ],
        },
        {
          'questionText': 'What should you do before recycling plastics?',
          'answers': [
            {'text': 'Rinse them out', 'score': 1},
            {'text': 'Throw them in the bin without cleaning', 'score': 0},
            {'text': 'Break them into small pieces', 'score': 0},
            {'text': 'Remove all labels', 'score': 0},
          ],
        },
        {
          'questionText': 'Which items should never be recycled?',
          'answers': [
            {'text': 'Plastic bottles', 'score': 0},
            {'text': 'Batteries', 'score': 1},
            {'text': 'Glass bottles', 'score': 0},
            {'text': 'Aluminum cans', 'score': 0},
          ],
        },
        // More recycling guideline questions...
      ],
    },
  ];
  // Add more categories...
}
