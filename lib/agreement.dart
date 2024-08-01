import 'package:flutter/material.dart';
import 'self_test.dart';

class Agreement extends StatefulWidget {
  const Agreement({super.key});

  @override
  AgreementState createState() => AgreementState();
}

class AgreementState extends State<Agreement> {
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
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 수평 중앙 정렬
            children: <Widget>[
              Text(
                '약관 동의',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              SizedBox(height: 35),
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
                builder: (context) => const SelfTest(), // SelfTest으로 이동
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
