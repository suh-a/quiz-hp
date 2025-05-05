import 'package:flutter/material.dart';
import 'inicio.dart';

class ResultadoPage extends StatelessWidget {
  final int score;
  final int totalQuestions;

  const ResultadoPage({
    super.key, 
    required this.score, 
    required this.totalQuestions,
  });

  String get resultMessage {
    final percent = (score / totalQuestions) * 100;
    
    if (percent >= 90) {
      return "Uau! Você é um verdadeiro Potterhead!";
    } else if (percent >= 70) {
      return "Muito bom! Você realmente conhece o mundo de Harry Potter!";
    } else if (percent >= 50) {
      return "Bom! Você tem um conhecimento razoável sobre Harry Potter.";
    } else if (percent >= 30) {
      return "Você precisa reler os livros ou reassistir os filmes!";
    } else {
      return "Você é um trouxa? Parece que precisa conhecer mais sobre o mundo mágico!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final percent = (score / totalQuestions) * 100;
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
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(isDesktop ? 40.0 : 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Resultado Final",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                  ),
                  
                  SizedBox(height: isDesktop ? 40 : 30),
                  
                  // Animação circular de progresso
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: isDesktop ? 250 : 200,
                          height: isDesktop ? 250 : 200,
                          child: CircularProgressIndicator(
                            value: score / totalQuestions,
                            strokeWidth: isDesktop ? 18 : 15,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              percent >= 70 ? Colors.green : (percent >= 40 ? Colors.amber : Colors.red),
                            ),
                          ),
                        ),
                        Container(
                          width: isDesktop ? 220 : 170,
                          height: isDesktop ? 220 : 170,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromARGB(255, 18, 0, 49).withOpacity(0.9),
                            border: Border.all(
                              color: Colors.amber.withOpacity(0.5),
                              width: 2,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$score/$totalQuestions",
                                style: TextStyle(
                                  fontSize: isDesktop ? 44 : 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "${percent.toStringAsFixed(0)}%",
                                style: TextStyle(
                                  fontSize: isDesktop ? 28 : 24,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: isDesktop ? 40 : 30),
                  
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          const Color.fromARGB(255, 18, 0, 49).withOpacity(0.85),
                          Colors.indigo.shade900.withOpacity(0.85),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.amber.withOpacity(0.5),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      resultMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isDesktop ? 24 : 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: isDesktop ? 50 : 40),
                  
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      width: isDesktop ? 280 : 240,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.amber.shade700,
                            Colors.amber.shade800,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.4),
                            blurRadius: 8,
                            spreadRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => const InicioPage()),
                              (route) => false,
                            );
                          },
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.replay,
                                  color: Colors.black,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Tentar Novamente",
                                  style: TextStyle(
                                    fontSize: isDesktop ? 20 : 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
  }
}
