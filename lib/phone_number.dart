import 'package:flutter/material.dart';
import 'agreement.dart';
import 'dart:async'; // Timer를 사용하기 위해 추가

class PhoneNumber extends StatefulWidget {
  const PhoneNumber({super.key});

  @override
  PhoneNumberState createState() => PhoneNumberState();
}

class PhoneNumberState extends State<PhoneNumber> {
  String? _selectedCarrier; // 선택된 통신사를 저장할 변수
  String _timerText = '05:00'; // 초기 타이머 텍스트 설정
  Timer? _timer; // Timer 인스턴스
  int _start = 300; // 5분을 초 단위로 설정

  final List<String> _carriers = [
    'SKT',
    'KT',
    'LG U+',
    'SKT 알뜰폰',
    'KT 알뜰폰',
    'LG U+ 알뜰폰',
  ]; // 통신사 리스트

  void _startTimer() {
    // 타이머가 이미 실행 중이면 중지
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _start = 300; // 5분으로 설정
    _timerText = '05:00'; // 타이머 텍스트 초기화

    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        timer.cancel(); // 타이머가 끝나면 중지
      } else {
        setState(() {
          _start--;
          final minutes = (_start / 60).floor();
          final seconds = _start % 60;
          _timerText =
              '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // 위젯이 사라질 때 타이머 취소
    super.dispose();
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
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // 수직 중앙 정렬
            crossAxisAlignment: CrossAxisAlignment.center, // 수평 중앙 정렬
            children: <Widget>[
              const Text(
                '본인인증을 해주세요.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 시작점에 맞추기
                children: <Widget>[
                  const Text(
                    '통신사',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8), // 레이블과 텍스트 필드 사이의 간격 설정
                  SizedBox(
                    width: 250, // 가로 크기 설정
                    height: 50, // 세로 크기 설정
                    child: DropdownButtonFormField<String>(
                      value: _selectedCarrier,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // 테두리 둥글게 설정
                          borderSide: const BorderSide(
                            color: Color(0xFFEE8F00), // 테두리 색상 설정
                            width: 1, // 테두리 두께 설정
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // 테두리 둥글게 설정
                          borderSide: const BorderSide(
                            color: Color(0xFFEE8F00), // 테두리 색상 설정
                            width: 1, // 테두리 두께 설정
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10), // 테두리 둥글게 설정
                          borderSide: const BorderSide(
                            color: Color(0xFFEE8F00), // 테두리 색상 설정
                            width: 1, // 테두리 두께 설정
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          left: 15.0, // 좌측 여백
                          right: 10.0, // 우측 여백
                        ),
                      ),
                      items: _carriers.map((carrier) {
                        return DropdownMenuItem<String>(
                          value: carrier,
                          child: Text(carrier),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCarrier = value;
                        });
                      },
                      hint: const Text(
                        '통신사를 선택하세요',
                        style: TextStyle(
                          color: Color(0xFFA6A6A6), // 힌트 텍스트 색상 설정
                          fontSize: 16, // 힌트 텍스트 크기 설정
                        ),
                      ),
                      icon: const Icon(
                        Icons.arrow_drop_down, // 드롭다운 아이콘 설정
                        color: Color(0xFFEE8F00), // 아이콘 색상 설정
                      ),
                      iconSize: 35, // 아이콘 크기 설정
                      dropdownColor: Colors.white, // 드롭다운 메뉴 배경색 설정
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Align(
                alignment: Alignment.center, // 가로 중앙 정렬
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 시작점에 맞추기
                  children: <Widget>[
                    const Text(
                      '휴대폰 번호',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 250, // 가로 크기 설정
                      height: 50, // 세로 크기 설정
                      child: Stack(
                        children: <Widget>[
                          TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // 테두리 둥글게 설정
                                borderSide: const BorderSide(
                                  color: Color(0xFFEE8F00), // 테두리 색상 설정
                                  width: 1, // 테두리 두께 설정
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // 테두리 둥글게 설정
                                borderSide: const BorderSide(
                                  color: Color(0xFFEE8F00), // 테두리 색상 설정
                                  width: 1, // 테두리 두께 설정
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // 테두리 둥글게 설정
                                borderSide: const BorderSide(
                                  color: Color(0xFFEE8F00), // 테두리 색상 설정
                                  width: 1, // 테두리 두께 설정
                                ),
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 15.0, // 좌측 여백
                              ),
                              hintText: '01012345678', // 힌트 텍스트 설정
                              hintStyle: const TextStyle(
                                color: Color(0xFFA6A6A6), // 힌트 텍스트 색상 설정
                                fontSize: 16, // 힌트 텍스트 크기 설정
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 10,
                            child: SizedBox(
                              width: 84, // 버튼의 정확한 가로 크기
                              height: 28, // 버튼의 정확한 세로 크기
                              child: TextButton(
                                onPressed: () {
                                  _startTimer(); // 인증번호 전송 버튼 클릭 시 타이머 시작
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      const Color(0xFFEE8F00), // 버튼 배경색
                                  padding: EdgeInsets.zero, // 버튼 내부 여백을 제거
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        5), // 버튼 모서리 둥글게 설정
                                  ),
                                ),
                                child: const Text(
                                  '인증번호 전송',
                                  style: TextStyle(fontSize: 12), // 텍스트 크기 설정
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
              const SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 시작점에 맞추기
                children: <Widget>[
                  const Text(
                    '인증번호',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 250, // 가로 크기 설정
                    height: 50, // 세로 크기 설정
                    child: Stack(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // 테두리 둥글게 설정
                              borderSide: const BorderSide(
                                color: Color(0xFFEE8F00), // 테두리 색상 설정
                                width: 1, // 테두리 두께 설정
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // 테두리 둥글게 설정
                              borderSide: const BorderSide(
                                color: Color(0xFFEE8F00), // 테두리 색상 설정
                                width: 1, // 테두리 두께 설정
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // 테두리 둥글게 설정
                              borderSide: const BorderSide(
                                color: Color(0xFFEE8F00), // 테두리 색상 설정
                                width: 1, // 테두리 두께 설정
                              ),
                            ),
                            contentPadding: const EdgeInsets.only(
                              left: 15.0, // 좌측 여백
                            ),
                            hintText: '인증번호를 입력하세요', // 힌트 텍스트 설정
                            hintStyle: const TextStyle(
                              color: Color(0xFFA6A6A6), // 힌트 텍스트 색상 설정
                              fontSize: 16, // 힌트 텍스트 크기 설정
                            ),
                          ),
                        ),
                        Positioned(
                          right: 10,
                          top: 14,
                          child: SizedBox(
                            width: 45, // 타이머 박스 가로 크기 설정
                            height: 20, // 타이머 박스 세로 크기 설정
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF3C8), // 타이머 박스 배경색
                                borderRadius:
                                    BorderRadius.circular(5), // 둥근 모서리
                              ),
                              child: Center(
                                child: Text(
                                  _timerText, // 타이머 표시 스트
                                  style: const TextStyle(
                                    color: Color(0xFFEE8F00), // 텍스트 색상
                                    fontSize: 12, // 텍스트 크기
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0), // 텍스트와 버튼 사이의 간격
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEE8F00), // 배경색 주황색 설정
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // 둥근 모서리 설정
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 22.0, // 수직 여백
                    horizontal: 102.0, // 수평 여백
                  ),
                ),
                child: const Text(
                  '인증하기',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w600, // 볼드체 설정
                    color: Colors.white, // 텍스트 색상 흰색 설정
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: InkWell(
                  onTap: () {
                    // 인증번호가 오지 않나요? 클릭 시의 동작
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      '인증번호가 오지 않나요?',
                      style: TextStyle(
                        decoration: TextDecoration.underline, // 밑줄 추가
                        color: Colors.grey, // 텍스트 색상 설정
                        fontSize: 12, // 텍스트 크기 설정
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
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
                builder: (context) => const Agreement(), // Agreement으로 이동
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
