import 'package:flutter/material.dart';
import 'quiz_page.dart';
import 'dart:math' as math;

class InicioPage extends StatefulWidget {
  const InicioPage({super.key});

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ParticleDot> _particles = [];
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    
    // Create magical floating particles
    for (int i = 0; i < 50; i++) {
      _particles.add(ParticleDot(
        position: Offset(
          math.Random().nextDouble() * 400 - 200,
          math.Random().nextDouble() * 400 - 200,
        ),
        size: math.Random().nextDouble() * 4 + 1,
        opacity: math.Random().nextDouble() * 0.6 + 0.2,
        speed: math.Random().nextDouble() * 1 + 0.5,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 600;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Imagem de fundo com efeito de movimento
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.1 + 0.05 * math.sin(_controller.value * 2 * math.pi),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('lib/assets/harrypotter.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          
          // Gradiente de sobreposição para melhorar a legibilidade do texto
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.8),
                ],
                stops: const [0.2, 0.7, 1.0],
              ),
            ),
          ),
          
          // Partículas mágicas flutuando
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlesPainter(_particles, _controller.value),
                size: Size.infinite,
              );
            },
          ),
          
          // Sobreposição com o conteúdo
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isDesktop ? 48.0 : 24.0,
                ),
                child: Column(
                  children: [
                    // Título com efeito de sombra
                    SizedBox(height: screenHeight * 0.1),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            0,
                            3 * math.sin(_controller.value * 2 * math.pi),
                          ),
                          child: child,
                        );
                      },
                      child: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            Colors.amber.shade200,
                            Colors.amber.shade300,
                            Colors.amber.shade600,
                            Colors.amber.shade300,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          'Quiz Harry Potter',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: isDesktop ? 52 : 38,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.amber.shade900.withOpacity(0.7),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                              const Shadow(
                                color: Colors.black,
                                blurRadius: 5,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Varinha decorativa
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: AnimatedBuilder(
                        animation: _controller,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: math.sin(_controller.value * 2 * math.pi) * 0.03,
                            child: Container(
                              width: isDesktop ? 120 : 80,
                              height: 4,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.amber.withOpacity(0),
                                    Colors.amber,
                                    Colors.amber.withOpacity(0),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.amber.withOpacity(0.6),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Espaço flexível para empurrar o conteúdo para baixo
                    const Spacer(),
                    
                    // Caixa decorativa para o texto principal
                    Container(
                      padding: EdgeInsets.all(isDesktop ? 32 : 24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            const Color.fromARGB(255, 18, 0, 49).withOpacity(0.8),
                            Colors.indigo.shade900.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.amber.withOpacity(0.5),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.2),
                            blurRadius: 15,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(
                                  0,
                                  4 * math.sin(_controller.value * 3 * math.pi),
                                ),
                                child: child,
                              );
                            },
                            child: Text(
                              'O quão fã você é do mundo mágico?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: isDesktop ? 32 : 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                height: 1.2,
                                shadows: const [
                                  Shadow(
                                    blurRadius: 8,
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Teste seus conhecimentos sobre Harry Potter neste quiz mágico!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isDesktop ? 18 : 16,
                              color: Colors.white.withOpacity(0.9),
                              height: 1.4,
                            ),
                          ),
                          SizedBox(height: isDesktop ? 32 : 24),
                          
                          // Botão animado
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                    pageBuilder: (_, animation, __) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: const QuizPage(),
                                      );
                                    },
                                    transitionDuration: const Duration(milliseconds: 600),
                                  ),
                                );
                              },
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Transform.translate(
                                    offset: Offset(
                                      0,
                                      2 * math.sin(_controller.value * 5 * math.pi),
                                    ),
                                    child: Container(
                                      width: isDesktop ? 280 : 230,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Colors.amber.shade600,
                                            Colors.amber.shade700,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.amber.withOpacity(0.6),
                                            blurRadius: 15,
                                            offset: const Offset(0, 5),
                                            spreadRadius: 1,
                                          ),
                                          const BoxShadow(
                                            color: Colors.black45,
                                            blurRadius: 5,
                                            offset: Offset(2, 4),
                                          ),
                                        ],
                                      ),
                                      child: Stack(
                                        children: [
                                          // Efeito brilhante animado
                                          Positioned.fill(
                                            child: ShaderMask(
                                              blendMode: BlendMode.srcIn,
                                              shaderCallback: (Rect bounds) {
                                                return LinearGradient(
                                                  begin: Alignment(
                                                    -1.0 + 2.0 * ((0.5 + _controller.value) % 1.0),
                                                    0.0,
                                                  ),
                                                  end: Alignment(
                                                    0.0 + 2.0 * ((0.5 + _controller.value) % 1.0),
                                                    0.0,
                                                  ),
                                                  colors: [
                                                    Colors.amber.withOpacity(0.0),
                                                    Colors.white.withOpacity(0.5),
                                                    Colors.amber.withOpacity(0.0),
                                                  ],
                                                ).createShader(bounds);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(30),
                                                ),
                                              ),
                                            ),
                                          ),
                                          
                                          // Texto do botão
                                          Center(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.auto_awesome,
                                                  color: Colors.black.withOpacity(0.8),
                                                  size: isDesktop ? 24 : 20,
                                                ),
                                                SizedBox(width: isDesktop ? 12 : 8),
                                                Text(
                                                  'Comece o Quiz',
                                                  style: TextStyle(
                                                    fontSize: isDesktop ? 22 : 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black.withOpacity(0.8),
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.1),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Classe para desenhar partículas mágicas
class ParticleDot {
  Offset position;
  double size;
  double opacity;
  double speed;

  ParticleDot({
    required this.position,
    required this.size,
    required this.opacity,
    required this.speed,
  });
}

class ParticlesPainter extends CustomPainter {
  final List<ParticleDot> particles;
  final double animationValue;

  ParticlesPainter(this.particles, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    for (final particle in particles) {
      final particleOffset = center + 
          Offset(
            particle.position.dx * math.sin(animationValue * 2 * math.pi * particle.speed),
            particle.position.dy * math.cos(animationValue * 2 * math.pi * particle.speed),
          );
      
      final paint = Paint()
        ..color = Colors.amber.withOpacity(particle.opacity * (0.5 + 0.5 * math.sin(animationValue * 2 * math.pi)))
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
      
      canvas.drawCircle(particleOffset, particle.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant ParticlesPainter oldDelegate) => true;
}
