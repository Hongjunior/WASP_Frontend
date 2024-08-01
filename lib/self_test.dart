import 'package:flutter/material.dart';
import 'home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SelfTest(),
    );
  }
}

class SelfTest extends StatefulWidget {
  const SelfTest({super.key});

  @override
  SelfTestState createState() => SelfTestState();
}

class SelfTestState extends State<SelfTest> {
  final List<Map<String, String?>> _questions = [
    {'question': '당신은 기억력에 문제가 있습니까?', 'answer': null},
    {'question': '당신은 기억력이 10년 전보다 저하되었습니까?', 'answer': null},
    {'question': '당신은 기억력이 동년의 다른 사람들에 비해\n나쁘다고 생각하십니까?', 'answer': null},
    {'question': '당신은 기억력 저하로 일상생활에 불편을 느끼십니까?', 'answer': null},
    {'question': '당신은 최근에 일어난 일을 기억하는 것이 어렵습니까?', 'answer': null},
    {'question': '당신은 며칠 전에 나눈 대화 내용을 기억하는 것이 어렵습니까?', 'answer': null},
    {'question': '당신은 며칠 전에 한 약속을 기억하기 어렵습니까?', 'answer': null},
    {'question': '당신은 친한 사람의 이름을 기억하기 어렵습니까?', 'answer': null},
    {'question': '당신은 물건 둔 곳을 기억하기 어렵습니까?', 'answer': null},
    {'question': '당신은 이전보다 물건을 자주 잃어버립니까?', 'answer': null},
    {'question': '당신은 집 근처에서 길을 잃은 적이 있습니까?', 'answer': null},
    {'question': '당신은 가게에서 사려고 하는 두세 가지 물건의 이름을\n기억하기 어렵습니까?', 'answer': null},
    {'question': '당신은 가스불이나 전깃불 끄는 것을 기억하기 어렵습니까?', 'answer': null},
    {'question': '당신은 자주 사용하는 전화번호(자신 혹은 자녀의 집)를\n기억하기 어렵습니까?', 'answer': null},
  ];

  int _currentQuestionIndex = 0;

  void _answerQuestion(String answer) {
    setState(() {
      _questions[_currentQuestionIndex]['answer'] = answer;
      _currentQuestionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 기본 뒤로 가기 아이콘을 제거
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // 왼쪽 정렬
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30, // 아이콘 크기 설정
                color: Color(0xFFEE8F00), // 아이콘 색상 설정
              ),
              onPressed: () {
                Navigator.of(context).pop(); // 이전 화면으로 돌아가기
              },
            ),
            const SizedBox(width: 3), // 아이콘과 텍스트 사이의 간격 설정
            const Text(
              '뒤로 가기',
              style: TextStyle(
                color: Color(0xFFEE8F00), // 텍스트 색상 설정
                fontSize: 20, // 텍스트 크기 설정
                fontWeight: FontWeight.bold, // 볼드체 설정
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent, // 배경색 투명 설정
        elevation: 0, // 그림자 제거
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: const Color(0xFFEE8F00), // 테두리 색상
                    width: 1,
                  ),
                ),
                child: const Text(
                  '       치매 자가 진단 테스트       ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEE8F00),
                  ),
                ),
              ),
              const SizedBox(height: 50.0),
              // 질문 목록
              if (_currentQuestionIndex > 0)
                ..._questions.sublist(0, _currentQuestionIndex).map((q) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            q['question']!,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center, // 텍스트 가운데 정렬
                          ),
                          const SizedBox(height: 5.0),
                          Container(
                            width: 70,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: q['answer'] != null
                                  ? const Color(0xFFEE8F00)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: q['answer'] != null
                                  ? [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : null,
                            ),
                            alignment: Alignment.center, // 텍스트 가운데 정렬
                            child: Text(
                              q['answer'] ?? '답변 대기 중',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: q['answer'] != null
                                    ? Colors.white
                                    : Colors.black54,
                              ),
                              textAlign: TextAlign.center, // 텍스트 가운데 정렬
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  );
                }),
              // 현재 질문
              if (_currentQuestionIndex < _questions.length)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _questions[_currentQuestionIndex]['question']!,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // 텍스트 가운데 정렬
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => _answerQuestion('예'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 28.0,
                            ),
                            backgroundColor: const Color(0xFFEE8F00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            shadowColor: Colors.black,
                            elevation: 5.0,
                          ),
                          child: const Text(
                            '예',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        ElevatedButton(
                          onPressed: () => _answerQuestion('아니요'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 15.0,
                            ),
                            backgroundColor: const Color(0xFFEE8F00),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            shadowColor: Colors.black,
                            elevation: 5.0,
                          ),
                          child: const Text(
                            '아니요',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              const SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: const Color(0xFFEE8F00), // 주황색 배경
        height: 75, // 버튼 세로 크기 설정
        width: double.infinity, // 화면 가로 전체 차지
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(), // HomeScreen으로 이동
              ),
            );
          },
          child: const Text(
            '다음',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white, // 버튼 텍스트 색상
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
