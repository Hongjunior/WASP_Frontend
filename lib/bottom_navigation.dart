import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home.dart';
import 'quiz.dart';
import 'chat.dart';
import 'honeycomb.dart';

class BottomNavigator extends StatefulWidget {
  final int currentIndex;

  const BottomNavigator({super.key, required this.currentIndex});

  @override
  BottomNavigatorState createState() => BottomNavigatorState();
}

class BottomNavigatorState extends State<BottomNavigator> {
  void _onItemTapped(int index) {
    Widget newScreen;

    // 각 인덱스에 따라 화면을 설정합니다.
    switch (index) {
      case 0:
        newScreen = const HomeScreen();
        break;
      case 1:
        newScreen = const QuizScreen();
        break;
      case 2:
        newScreen = const ChatScreen();
        break;
      case 3:
        newScreen = const HoneycombScreen();
        break;
      default:
        return;
    }

    if (widget.currentIndex != index) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => newScreen),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1), // 배경색 설정
      height: 90.0, // 세로 높이 설정
      child: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              color: widget.currentIndex == 0
                  ? const Color(0xFFEE8F00)
                  : null, // 선택된 상태에서 주황색
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/quiz.svg',
              color: widget.currentIndex == 1
                  ? const Color(0xFFEE8F00)
                  : null, // 선택된 상태에서 주황색
            ),
            label: '퀴즈',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/chat.svg',
              color: widget.currentIndex == 2
                  ? const Color(0xFFEE8F00)
                  : null, // 선택된 상태에서 주황색
            ),
            label: '말벗',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/honeycomb.svg',
              color: widget.currentIndex == 3
                  ? const Color(0xFFEE8F00)
                  : null, // 선택된 상태에서 주황색
            ),
            label: '벌집',
          ),
        ],
        currentIndex: widget.currentIndex,
        selectedItemColor: const Color(0xFFEE8F00), // 주황색으로 선택된 항목 색상 설정
        onTap: _onItemTapped,
        backgroundColor:
            Colors.transparent, // BottomNavigationBar 자체 배경색을 투명으로 설정
        type: BottomNavigationBarType.fixed, // 모든 항목을 고정된 형태로 표시
        elevation: 0, // 그림자 제거
        selectedLabelStyle: const TextStyle(
            fontSize: 13.0, fontWeight: FontWeight.bold), // 선택된 항목의 글씨 스타일
        unselectedLabelStyle: const TextStyle(
            fontSize: 13.0, fontWeight: FontWeight.bold), // 선택되지 않은 항목의 글씨 스타일
      ),
    );
  }
}
