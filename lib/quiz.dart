import 'package:flutter/material.dart';
import 'question.dart';
import 'bottom_navigation.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          children: <Widget>[
            MouseRegion(
              cursor: SystemMouseCursors.click, // 마우스 커서를 클릭 커서로 변경
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const Question()), // Question으로 변경
                  );
                },
                child: Container(
                  width: 250, // 가로 크기 설정
                  height: 130, // 세로 크기 설정
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF5E6), // 내부 색상
                    borderRadius: BorderRadius.circular(10.0), // 테두리 둥글기
                    border: Border.all(
                      color: const Color(0xFFEE8F00), // 테두리 색상
                      width: 2.0, // 테두리 두께
                    ),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 12.0,
                        right: 12.0,
                        child: Image.asset(
                          'assets/icons/logo2.png',
                        ),
                      ),
                      const Positioned(
                        top: 12.0,
                        left: 12.0,
                        child: Text(
                          '퀴즈 풀기',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40), // 박스와 아래 콘텐츠 사이의 간격
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                '             퀴즈 결과 분석',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 5), // 레이블과 이미지 사이의 간격 설정
            SizedBox(
              width: 250, // 가로 크기 설정
              height: 180, // 세로 크기 설정
              child: Image.asset(
                'assets/icons/quizresult.png',
                fit: BoxFit.contain, // 크기 맞추기
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              '정답 개수에 따라 그래프 속 표정이 변해요',
              style: TextStyle(
                fontSize: 13.0,
                color: Color(0xFF828282), // 텍스트 색상 설정
              ),
              textAlign: TextAlign.center, // 텍스트를 가운데 정렬
            ),
            const SizedBox(height: 30), // 텍스트와 아래 콘텐츠 사이의 간격
            // PNG 이미지를 가로로 배치하는 첫 번째 Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/icons/0.png',
                ),
                const SizedBox(width: 10), // 이미지 간격 설정
                Image.asset(
                  'assets/icons/1-2.png',
                ),
                const SizedBox(width: 10), // 이미지 간격 설정
                Image.asset(
                  'assets/icons/3-4.png',
                ),
              ],
            ),
            const SizedBox(height: 10), // 두 번째 Row와 첫 번째 Row 사이의 간격
            // PNG 이미지를 가로로 배치하는 두 번째 Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/icons/5-6.png',
                ),
                const SizedBox(width: 10), // 이미지 간격 설정
                Image.asset(
                  'assets/icons/7.png',
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigator(currentIndex: 1),
    );
  }
}
