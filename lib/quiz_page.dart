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
          // Tempo esgotado, avançar para próxima pergunta
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

      // Verificar se a resposta está correta
      if (selectedIndex == questions[currentQuestionIndex].correctAnswerIndex) {
        score++;
      }
    });

    // Aguardar um momento para mostrar a resposta correta antes de avançar
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
      // Quiz finalizado
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('lib/assets/harrypotter.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
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
                        color: Colors.white,
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
                        color: const Color.fromARGB(255, 18, 0, 49).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.amber, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
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
                
                // Indicador de progresso
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pergunta ${currentQuestionIndex + 1} de ${questions.length}",
                          style: TextStyle(
                            fontSize: isDesktop ? 18 : 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: const [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                        ),
                        Text(
                          "Pontuação: $score",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 4,
                                color: Colors.black,
                                offset: Offset(1, 1),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 8),
                    
                    // Barra de progresso
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (currentQuestionIndex + 1) / questions.length,
                        backgroundColor: Colors.grey[800],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.amber),
                        minHeight: 8,
                      ),
                    ),
                  ],
                ),
                
                SizedBox(height: isDesktop ? 40 : 24),
                
                // Pergunta
                Container(
                  padding: EdgeInsets.all(isDesktop ? 24 : 16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color.fromARGB(255, 18, 0, 49).withOpacity(0.9),
                        Colors.black.withOpacity(0.7),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.amber.withOpacity(0.5),
                      width: 1,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    question.questionText,
                    style: TextStyle(
                      fontSize: isDesktop ? 26 : 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.3,
                      shadows: const [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black,
                          offset: Offset(1, 1),
                        )
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                SizedBox(height: isDesktop ? 32 : 20),
                
                // Opções de resposta
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: isDesktop ? 600 : double.infinity,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: List.generate(
                                question.options.length,
                                (index) {
                                  final isCorrect = index == question.correctAnswerIndex;
                                  final isSelected = index == selectedAnswerIndex;
                                  final isIncorrectSelection = answerSelected && isSelected && !isCorrect;
                                  final showAsCorrect = answerSelected && isCorrect;
                                  
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                                    child: MouseRegion(
                                      cursor: answerSelected 
                                        ? SystemMouseCursors.basic 
                                        : SystemMouseCursors.click,
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 300),
                                        height: isDesktop ? 65 : 60,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              if (showAsCorrect)
                                                Colors.green.shade700
                                              else if (isIncorrectSelection)
                                                Colors.red.shade700
                                              else
                                                const Color.fromARGB(255, 18, 0, 49),
                                              if (showAsCorrect)
                                                Colors.green.shade800
                                              else if (isIncorrectSelection)
                                                Colors.red.shade900
                                              else
                                                Colors.indigo.shade900,
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: showAsCorrect
                                                ? Colors.green.shade300
                                                : isIncorrectSelection
                                                    ? Colors.red.shade300
                                                    : Colors.amber.withOpacity(0.5),
                                            width: showAsCorrect || isIncorrectSelection ? 2 : 1,
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black.withOpacity(0.3),
                                              blurRadius: 8,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          onTap: answerSelected ? null : () => checkAnswer(index),
                                          borderRadius: BorderRadius.circular(12),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Row(
                                              children: [
                                                if (answerSelected)
                                                  Icon(
                                                    showAsCorrect
                                                        ? Icons.check_circle
                                                        : isIncorrectSelection
                                                            ? Icons.cancel
                                                            : Icons.circle_outlined,
                                                    color: showAsCorrect
                                                        ? Colors.green.shade100
                                                        : isIncorrectSelection
                                                            ? Colors.red.shade100
                                                            : Colors.white.withOpacity(0.7),
                                                    size: 24,
                                                  )
                                                else
                                                  Container(
                                                    width: 28,
                                                    height: 28,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        color: Colors.amber,
                                                        width: 2,
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        String.fromCharCode(65 + index), // A, B, C, D
                                                        style: const TextStyle(
                                                          color: Colors.amber,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                const SizedBox(width: 12),
                                                Expanded(
                                                  child: Text(
                                                    question.options[index],
                                                    style: TextStyle(
                                                      fontSize: isDesktop ? 18 : 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: showAsCorrect || isIncorrectSelection
                                                          ? Colors.white
                                                          : Colors.white.withOpacity(
                                                              answerSelected ? 0.6 : 0.9),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
