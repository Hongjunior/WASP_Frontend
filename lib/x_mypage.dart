import 'package:flutter/material.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  MyPageScreenState createState() => MyPageScreenState();
}

class MyPageScreenState extends State<MyPageScreen> {
  bool _isMyPageSelected = true; // 마이페이지 버튼 상태 관리, 초기값을 true로 설정
  bool _isSettingsSelected = false; // 환경설정 버튼 상태 관리

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // AppBar 높이 설정
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 50.0), // 양쪽에 50의 마진
          child: AppBar(
            automaticallyImplyLeading: false, // 기본 뒤로 가기 아이콘을 제거
            backgroundColor: Colors.transparent, // 배경색 투명 설정
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // '마이페이지' 텍스트 버튼
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isMyPageSelected = true; // 클릭 시 상태 변경
                      _isSettingsSelected = false; // 다른 버튼 상태 변경
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '마이페이지',
                          style: TextStyle(
                            fontSize: 20.0, // 글씨 크기 설정
                            fontWeight: FontWeight.bold, // 볼드체 설정
                            color: _isMyPageSelected
                                ? Colors.black
                                : Colors.grey, // 글씨 색상 설정
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        child: AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 300), // 애니메이션 시간 설정
                          height: 5.0, // 밑줄의 높이
                          width: _isMyPageSelected ? 120.0 : 0.0, // 밑줄의 너비
                          decoration: BoxDecoration(
                            color: _isMyPageSelected
                                ? const Color(0xFFFFCC16)
                                : Colors.transparent, // 밑줄의 색상 설정
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(10.0), // 왼쪽 끝 둥글기
                              right: Radius.circular(10.0), // 오른쪽 끝 둥글기
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // '환경설정' 텍스트 버튼
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSettingsSelected = true; // 클릭 시 상태 변경
                      _isMyPageSelected = false; // 다른 버튼 상태 변경
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '환경설정',
                          style: TextStyle(
                            fontSize: 20.0, // 글씨 크기 설정
                            fontWeight: FontWeight.bold, // 볼드체 설정
                            color: _isSettingsSelected
                                ? Colors.black
                                : Colors.grey, // 글씨 색상 설정
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -2,
                        child: AnimatedContainer(
                          duration:
                              const Duration(milliseconds: 300), // 애니메이션 시간 설정
                          height: 7.0, // 밑줄의 높이
                          width: _isSettingsSelected ? 120.0 : 0.0, // 밑줄의 너비
                          decoration: BoxDecoration(
                            color: _isSettingsSelected
                                ? const Color(0xFFFFCC16)
                                : Colors.transparent, // 밑줄의 색상 설정
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(10.0), // 왼쪽 끝 둥글기
                              right: Radius.circular(10.0), // 오른쪽 끝 둥글기
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          '마이 페이지',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
