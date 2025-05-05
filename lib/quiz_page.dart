import 'dart:async';
import 'package:flutter/material.dart';
import 'question_model.dart';
import 'resultado_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  int timeLeft = 30;
  late Timer timer;
  bool answerSelected = false;
  int? selectedAnswerIndex;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (timeLeft > 0) {
          timeLeft--;
        } else {
          timer.cancel();
          goToNextQuestion();
        }
      });
    });
  }

  void checkAnswer(int selectedIndex) {
    if (answerSelected) return;

    setState(() {
      answerSelected = true;
      selectedAnswerIndex = selectedIndex;
      timer.cancel();

      if (selectedIndex == questions[currentQuestionIndex].correctAnswerIndex) {
        score++;
      }
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      goToNextQuestion();
    });
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        timeLeft = 30;
        answerSelected = false;
        selectedAnswerIndex = null;
      });
      startTimer();
    } else {
      timer.cancel();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResultadoPage(
            score: score,
            totalQuestions: questions.length,
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestionIndex];
    final isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A40), // Cor de fundo semelhante à primeira tela
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 40.0 : 16.0,
          vertical: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cabeçalho
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Quiz Harry Potter",
                  style: TextStyle(
                    fontSize: isDesktop ? 28 : 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade200,
                    shadows: const [
                      Shadow(
                        blurRadius: 8,
                        color: Colors.black,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.amber, width: 2),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "$timeLeft s",
                        style: TextStyle(
                          fontSize: isDesktop ? 20 : 18,
                          fontWeight: FontWeight.bold,
                          color: timeLeft > 10 ? Colors.white : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Imagem centralizada
            Center(
              child: Container(
                height: 180, // Aumentei o tamanho da imagem
                width: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(question.imagePath),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(color: Colors.amber, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Pergunta
            Center(
              child: Container(
                width: isDesktop ? 600 : 300, // Diminuí a largura da pergunta
                padding: EdgeInsets.all(isDesktop ? 24 : 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.amber.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  question.questionText,
                  style: TextStyle(
                    fontSize: isDesktop ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Opções de resposta
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: isDesktop ? 600 : 300, // Diminuí a largura dos botões
                  ),
                  child: ListView.builder(
                    itemCount: question.options.length,
                    itemBuilder: (context, index) {
                      final isCorrect = index == question.correctAnswerIndex;
                      final isSelected = index == selectedAnswerIndex;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isSelected
                                ? (isCorrect ? Colors.green : Colors.red)
                                : Colors.black.withOpacity(0.7),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: answerSelected ? null : () => checkAnswer(index),
                          child: Text(
                            question.options[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
