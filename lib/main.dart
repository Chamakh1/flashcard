import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class Flashcard {
  final String question;
  final String answer;

  Flashcard({required this.question, required this.answer});
}

class _MyAppState extends State<MyApp> {
  final List<Flashcard> _flashcards = [
    Flashcard(question: "What programming language does Flutter use?", answer: "Dart"),
    Flashcard(question: "Who you gonna call?", answer: "Ghostbusters!"),
    Flashcard(question: "What is the capital of France?", answer: "Paris"),
    Flashcard(question: "What is the chemical symbol for water?", answer: "H2O"),
    Flashcard(question: "What planet is known as the Red Planet?", answer: "Mars"),
    Flashcard(question: "Who wrote 'To be, or not to be'?", answer: "William Shakespeare"),
    Flashcard(question: "What is the largest mammal in the world?", answer: "Blue Whale"),
    Flashcard(question: "What is the smallest prime number?", answer: "2"),
    Flashcard(question: "What is the speed of light?", answer: "299,792,458 m/s"),
    Flashcard(question: "Who painted the Mona Lisa?", answer: "Leonardo da Vinci"),
    Flashcard(question: "What is the capital of Japan?", answer: "Tokyo"),
    Flashcard(question: "What is the square root of 64?", answer: "8"),
    Flashcard(question: "What year did the Titanic sink?", answer: "1912"),
    Flashcard(question: "Who discovered penicillin?", answer: "Alexander Fleming"),
    Flashcard(question: "What is the hardest natural substance on Earth?", answer: "Diamond"),
    Flashcard(question: "What is the tallest mountain in the world?", answer: "Mount Everest"),
    Flashcard(question: "What is the largest continent?", answer: "Asia"),
    Flashcard(question: "What is the currency of the United Kingdom?", answer: "Pound Sterling"),
    Flashcard(question: "What is the longest river in the world?", answer: "Nile"),
    Flashcard(question: "What is the chemical symbol for gold?", answer: "Au"),
    Flashcard(question: "Who is the author of 'Harry Potter'?", answer: "J.K. Rowling"),
    Flashcard(question: "What is the primary language spoken in Brazil?", answer: "Portuguese"),
    Flashcard(question: "What is the smallest country in the world?", answer: "Vatican City"),
    Flashcard(question: "What year did the first man land on the moon?", answer: "1969"),
  ];

  int _currentIndex = 0;
  int _score = 0;
  String _userAnswer = '';
  bool _isCorrect = false;
  bool _showAnswer = false;

  void _addNewFlashcard(String question, String answer) {
    setState(() {
      _flashcards.add(Flashcard(question: question, answer: answer));
    });
  }

  void _submitAnswer() {
    setState(() {
      _showAnswer = true;
      if (_userAnswer.toLowerCase().trim() == _flashcards[_currentIndex].answer.toLowerCase().trim()) {
        _score++;
        _isCorrect = true;
      } else {
        _isCorrect = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flashcards'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _showAddFlashcardDialog(context),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/back.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      height: 300,
                      child: FlipCard(
                        front: FlashcardView(
                          text: _flashcards[_currentIndex].question,
                          isCorrect: false,
                        ),
                        back: _showAnswer
                            ? Container(
                                color: _isCorrect ? Colors.green : Colors.red,
                                child: Center(
                                  child: Text(
                                    _isCorrect ? 'Correct!' : 'Incorrect!',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          enabled: !_showAnswer,
                          decoration: const InputDecoration(
                            
                            labelText: 'Your Answer',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _userAnswer = value;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: _showAnswer ? null : () {
                        _submitAnswer();
                        _clearTextField();
                      },
                      child: const Text('Submit Answer'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      color: Colors.white,
                      child: AnimatedOpacity(
                        opacity: _showAnswer ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 500),
                        child: Text(
                          _showAnswer
                              ? (_isCorrect
                                  ? 'Correct!'
                                  : 'Incorrect. Answer: ${_flashcards[_currentIndex].answer}')
                              : '',
                          style: TextStyle(
                            color: _isCorrect ? Colors.green : Colors.red,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color.fromARGB(186, 255, 255, 255)
                      ),
                      
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('Score: $_score', style: const TextStyle(fontSize: 24)),
                      )),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          color: Colors.white,
                          child: OutlinedButton.icon(
                            onPressed: showPreviousCard,
                            icon: const Icon(Icons.chevron_left),
                            label: const Text('Prev'),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: OutlinedButton.icon(
                            onPressed: _showAnswer ? showNextCard : null,
                            icon: const Icon(Icons.chevron_right),
                            label: const Text('Next'),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddFlashcardDialog(BuildContext context) {
    String question = '';
    String answer = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Flashcard'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Question'),
                onChanged: (value) {
                  question = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Answer'),
                onChanged: (value) {
                  answer = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (question.isNotEmpty && answer.isNotEmpty) {
                  _addNewFlashcard(question, answer);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void showNextCard() {
    setState(() {
      _currentIndex =
          (_currentIndex + 1 < _flashcards.length) ? _currentIndex + 1 : 0;
      _userAnswer = '';
      _isCorrect = false;
      _showAnswer = false;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 >= 0) ? _currentIndex - 1 : _flashcards.length - 1;
      _userAnswer = '';
      _isCorrect = false;
      _showAnswer = false;
    });
  }

  void _clearTextField() {
    setState(() {
      _userAnswer = '';
    });
  }
}

class FlashcardView extends StatelessWidget {
  final String text;
  final bool isCorrect;

  const FlashcardView({
    Key? key,
    required this.text,
    required this.isCorrect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: isCorrect ? Colors.green : Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
