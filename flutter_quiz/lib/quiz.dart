import 'package:flutter/material.dart';
import 'resultado.dart';

class Questao {
  final String pergunta;
  final List<String> alternativas;
  final int correta;

  const Questao({
    required this.pergunta,
    required this.alternativas,
    required this.correta,
  });
}

const List<Questao> questoes = [
  Questao(
    pergunta: 'O Arcadismo valorizava a simplicidade e a vida no campo. Qual expressão latina resume esse ideal de retorno à natureza?',
    alternativas: [
      'Carpe diem.',
      'Locus amoenus.',
      'Fugere urbem.',
      'In vino veritas.',
    ],
    correta: 2,
  ),
  Questao(
    pergunta: 'O Barroco brasileiro é marcado por contrastes e conflitos. Qual dessas características representa melhor esse estilo?"?',
    alternativas: [
      'Linguagem simples e objetiva.',
      'Valorização da razão.',
      'Dualismo entre corpo e alma.',
      'Nacionalismo ufanista.',
    ],
    correta: 2,
  ),
  Questao(
    pergunta: 'O Romantismo no Brasil teve três gerações. A segunda geração ficou conhecida como:',
    alternativas: [
      'Indianista.',
      'Condoreira.',
      'Ultrarromântica.',
      'Regionalista.',
    ],
    correta: 2,
  ),
  Questao(
    pergunta: 'No Realismo, há uma mudança na forma de retratar a sociedade. Qual é o principal foco desse movimento?',
    alternativas: [
      'Idealização do amor.',
      'Crítica social e análise psicológica.',
      'Exaltação da natureza.',
      'Religiosidade intensa.',
    ],
    correta: 1,
  ),
  Questao(
    pergunta: 'Machado de Assis é um dos principais autores do Realismo. Qual dessas obras é dele?',
    alternativas: [
      'Iracema.',
      'Dom Casmurro.',
      'Os Sertões.',
      'Macunaíma.',
    ],
    correta: 1,
  ),
  Questao(
    pergunta:
        'O Naturalismo é frequentemente associado ao determinismo. O que isso significa nas obras?',
    alternativas: [
      'Personagens livres de influências externas.',
      'Comportamentos explicados por hereditariedade e ambiente.',
      'Narrativas baseadas em fantasia.',
      'Valorização da subjetividade.',
    ],
    correta: 1,
  ),
  Questao(
    pergunta: 'O Modernismo brasileiro começou oficialmente em 1922. Qual evento marcou esse início?',
    alternativas: [
      'Semana de Arte Moderna.',
      'Revolução Industrial.',
      'Independência do Brasil.',
      'Tropicália.',
    ],
    correta: 0,
  ),
  Questao(
    pergunta:
        'A primeira fase do Modernismo no Brasil tinha como característica principal:',
    alternativas: [
      'Linguagem formal e rebuscada.',
      'Valorização da cultura europeia.',
      'Ruptura com padrões tradicionais.',
      'Temas exclusivamente religiosos.',
    ],
    correta: 2,
  ),
  Questao(
    pergunta: 'Em relação às funções da linguagem, quando o foco está na emoção do emissor, temos a função:',
    alternativas: [
      'Referencial.',
      'Fática.',
      'Emotiva.',
      'Conativa',
    ],
    correta: 2,
  ),
  Questao(
    pergunta: 'A crase ocorre na fusão de duas vogais idênticas. Em qual alternativa o uso da crase está correto?',
    alternativas: [
      'Vou à escola cedo.',
      'Entreguei o trabalho à você.',
      'Cheguei à casa dela ontem.',
      'Vou à pé para o treino.',
    ],
    correta: 0,
  ),
];

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _atual = 0;
  int? _selecionada;
  bool _respondeu = false;
  int _acertos = 0;

  Questao get _questao => questoes[_atual];

  void _selecionar(int index) {
    if (_respondeu) return;
    setState(() {
      _selecionada = index;
      _respondeu = true;
      if (index == _questao.correta) _acertos++;
    });
  }

  void _proxima() {
    if (_atual < questoes.length - 1) {
      setState(() {
        _atual++;
        _selecionada = null;
        _respondeu = false;
      });
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => ResultadoScreen(
            acertos: _acertos,
            total: questoes.length,
          ),
        ),
      );
    }
  }

  Color _corBotao(int index) {
    if (!_respondeu) {
      return _selecionada == index ? Colors.indigo.shade50 : Colors.white;
    }
    if (index == _questao.correta) return const Color(0xFFE8F5E9);
    if (index == _selecionada) return const Color(0xFFFFEBEE);
    return Colors.white;
  }

  Color corBorda(int index) {
    if (!_respondeu) {
      return _selecionada == index ? const Color.fromARGB(255, 181, 63, 130) : const Color(0xFFE0E0E0);
    }
    if (index == _questao.correta) return const Color.fromARGB(255, 102, 196, 105);
    if (index == _selecionada) return const Color.fromARGB(255, 164, 24, 14);
    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 181, 63, 108),
        foregroundColor: Colors.white,
        title: Text('Questão ${_atual + 1} de ${questoes.length}'),
        elevation: 0,
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_atual + 1) / questoes.length,
            backgroundColor: const Color(0xFFC5CAE9),
            valueColor: const AlwaysStoppedAnimation(Color.fromARGB(255, 181, 63, 122)),
            minHeight: 6,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 181, 63, 118),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      _questao.pergunta,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(
                    _questao.alternativas.length,
                    (i) {
                      final letra = ['A', 'B', 'C', 'D'][i];
                      return GestureDetector(
                        onTap: () => _selecionar(i),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _corBotao(i),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: corBorda(i), width: 2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: corBorda(i).withAlpha(38),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    letra,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: corBorda(i),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _questao.alternativas[i],
                                  style: const TextStyle(
                                      fontSize: 15, height: 1.4),
                                ),
                              ),
                              if (_respondeu)
                                Icon(
                                  i == _questao.correta
                                      ? Icons.check_circle
                                      : i == _selecionada
                                          ? Icons.cancel
                                          : null,
                                  color: i == _questao.correta
                                      ? const Color.fromARGB(255, 114, 202, 117)
                                      : const Color.fromARGB(255, 184, 45, 35),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  if (_respondeu)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _proxima,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 181, 63, 114),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          _atual < questoes.length - 1
                              ? 'Próxima Questão'
                              : 'Ver Resultado',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}