import 'package:flutter/material.dart';
import 'dart:async'; // Timer 사용을 위한 import
import 'dart:ui'; // BackdropFilter 사용을 위한 import

class Question2 extends StatelessWidget {
  final int currentQuestionIndex = 2; // 현재 문제 인덱스 (0부터 시작하므로 1은 두 번째 문제를 의미)

  const Question2({super.key});

  @override
  Widget build(BuildContext context) {
    // 전체 문제 수
    const int totalQuestions = 7;

    // 현재 문제에 대한 진척도 계산
    double progress = (currentQuestionIndex / totalQuestions).clamp(0.0, 1.0);

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
          ],
        ),
        backgroundColor: Colors.transparent, // 배경색 투명 설정
        elevation: 0, // 그림자 제거
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // 진척도 막대바
          SizedBox(
            height: 10,
            child: LinearProgressIndicator(
              value: progress, // 진척도 (현재 문제 / 총 문제 수)
              backgroundColor: const Color(0xFFBFBFBF), // 회색 배경
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFEE8F00)), // 주황색 채우기
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RichText(
                    text: const TextSpan(
                      text: '8월 2일에 금요일에\n아침 경로당에 같이 간\n지인은 ',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // 기본 텍스트 색상
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '영희',
                          style: TextStyle(
                            color: Color(0xFFEE8F00), // 주황색
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '(이)다.',
                          style: TextStyle(
                            color: Colors.black, // 검정색
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15.0),
                  const Text(
                    '(2/7)',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFBFBFBF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 80.0),
                  // 버튼을 좌우로 배치하는 Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // 좌우로 중앙 배치
                    children: <Widget>[
                      _buildOptionButton(
                          context, 'O', const Color(0xFF3A3A3A)), // O 버튼
                      const SizedBox(width: 15), // 버튼 간격 설정
                      _buildOptionButton(
                          context, 'X', const Color(0xFFEE8F00)), // X 버튼
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 선택지 버튼을 생성하는 위젯
  Widget _buildOptionButton(
      BuildContext context, String optionText, Color backgroundColor) {
    return SizedBox(
      width: 140,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          if (optionText == 'X') {
            _showAnswerAnimation(context);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const Question2(), // 선택 후 이동할 화면
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor, // 버튼 배경 색상 설정
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0), // 모서리 둥글기 설정
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          textStyle: const TextStyle(
            fontSize: 24.0, // 글씨 크기 조정
            fontWeight: FontWeight.bold,
          ),
        ),
        child: Text(optionText),
      ),
    );
  }

  void _showAnswerAnimation(BuildContext context) {
    // 애니메이션을 화면 상단에 표시
    showDialog(
      context: context,
      barrierDismissible: false, // 배경 클릭으로 다이얼로그 닫기 방지
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0), // 흐림 효과 없음
                child: Container(
                  color: Colors.transparent, // 배경색 없음
                ),
              ),
            ),
            Center(
              child: AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent, // 배경색 없음
                  ),
                  child: const Center(
                    child: Text(
                      'X',
                      style: TextStyle(
                        fontSize: 300,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        decoration: TextDecoration.none, // 밑줄 제거
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    // 3초 후에 다이얼로그를 닫고 결과 화면으로 이동
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Question2(), // 애니메이션 후 이동할 화면
        ),
      );
    });
  }
}
