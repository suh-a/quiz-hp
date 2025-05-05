class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

// Lista de perguntas do quiz sobre Harry Potter
final List<Question> questions = [
  Question(
    questionText: "Qual é o nome completo de Harry Potter?",
    options: ["Harry James Potter", "Harry Albus Potter", "Harry Sirius Potter", "Harry Severus Potter"],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: "Qual é a casa de Hogwarts que Harry pertence?",
    options: ["Sonserina", "Corvinal", "Lufa-Lufa", "Grifinória"],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: "Quem é o diretor de Hogwarts no início da série?",
    options: ["Severus Snape", "Albus Dumbledore", "Minerva McGonagall", "Rubeus Hagrid"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Qual é o feitiço para desarmar um oponente?",
    options: ["Accio", "Expelliarmus", "Wingardium Leviosa", "Lumos"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Qual animal de estimação Harry recebeu de Hagrid?",
    options: ["Um sapo", "Um rato", "Uma coruja", "Um gato"],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "Qual era o nome da coruja de Harry?",
    options: ["Errol", "Edwiges", "Hermes", "Píchi"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Quem é o padrinho de Harry Potter?",
    options: ["Remo Lupin", "Albus Dumbledore", "Sirius Black", "Arthur Weasley"],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "Como é chamado o esporte bruxo jogado em vassouras?",
    options: ["Quadribol", "Vassourobol", "Bruxobol", "Magicbol"],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: "Qual é a função de Harry no time de Quadribol?",
    options: ["Goleiro", "Artilheiro", "Batedor", "Apanhador"],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: "Qual é o nome do banco dos bruxos?",
    options: ["Gringotts", "Magicbank", "Wizardbank", "Goldcoin"],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: "Qual feitiço é usado para fazer objetos levitarem?",
    options: ["Accio", "Alohomora", "Wingardium Leviosa", "Lumos"],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "Qual é a plataforma onde o Expresso de Hogwarts parte?",
    options: ["Plataforma 7½", "Plataforma 9¾", "Plataforma 10½", "Plataforma 8⅔"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Como são chamados os não-mágicos no mundo de Harry Potter?",
    options: ["Comuns", "Normais", "Trouxas", "Mortais"],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: "Qual é o nome do elfo doméstico que tentou 'salvar' Harry no segundo livro?",
    options: ["Winky", "Dobby", "Kreacher", "Hokey"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Quantas Horcruxes Voldemort criou intencionalmente?",
    options: ["5", "6", "7", "8"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Qual é a forma do patrono de Harry Potter?",
    options: ["Cervo", "Lobo", "Cão", "Fênix"],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: "Quem matou Albus Dumbledore?",
    options: ["Draco Malfoy", "Bellatrix Lestrange", "Lord Voldemort", "Severus Snape"],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: "Qual é a varinha mais poderosa mencionada na série?",
    options: ["Varinha de Sabugueiro", "Varinha de Fênix", "Varinha de Teixo", "Varinha de Videira"],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: "Qual criatura guarda o cofre de alta segurança em Gringotts?",
    options: ["Hipogrifo", "Dragão", "Basilisco", "Troll"],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: "Qual é o nome da mãe de Harry Potter?",
    options: ["Molly", "Lily", "Petunia", "Narcissa"],
    correctAnswerIndex: 1,
  ),
];
