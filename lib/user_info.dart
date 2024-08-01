import 'package:flutter/material.dart';
import 'phone_number.dart';
import 'package:intl/intl.dart'; // intl 패키지 임포트

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  UserInfoState createState() => UserInfoState();
}

class UserInfoState extends State<UserInfo> {
  DateTime _selectedDate = DateTime.now(); // 기본 날짜는 현재 날짜로 설정

  // 날짜 선택 함수
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900), // 선택할 수 있는 첫 해
      lastDate: DateTime(2025), // 선택할 수 있는 마지막 해
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
                primary: Color(0xFFEE8F00),
                secondary: Color(0xFFEE8F00)), // 헤더 색상 및 버튼 색상
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFEE8F00)), // 버튼 색상
            ),
            // 추가 스타일을 여기서 설정할 수 있습니다
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 날짜 포맷팅
    String formattedDate = DateFormat('yyyy / MM / dd').format(_selectedDate);

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
                '개인정보를 입력해 주세요.',
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
                    '이름',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8), // 레이블과 텍스트 필드 사이의 간격 설정
                  SizedBox(
                    width: 250, // 가로 크기 설정
                    height: 50, // 세로 크기 설정
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '장말벗', // 힌트 텍스트 추가
                        hintStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFFA6A6A6), // 힌트 텍스트 색상 설정
                        ),
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15.0), // 좌우 여백 추가
                      ),
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
                      '성별',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisSize: MainAxisSize.min, // Row의 크기를 버튼들에 맞추기
                      children: <Widget>[
                        SizedBox(
                          width: 120, // 버튼 가로 크기 설정
                          height: 50, // 버튼 세로 크기 설정
                          child: TextButton(
                            onPressed: () {
                              // 남성 버튼 클릭 시의 동작
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Color(0xFFEE8F00)), // 테두리 색상
                              ),
                            ),
                            child: const Text(
                              '남성',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // 버튼 텍스트 색상
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10), // 버튼 사이 간격
                        SizedBox(
                          width: 120, // 버튼 가로 크기 설정
                          height: 50, // 버튼 세로 크기 설정
                          child: TextButton(
                            onPressed: () {
                              // 여성 버튼 클릭 시의 동작
                            },
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Color(0xFFEE8F00)), // 테두리 색상
                              ),
                            ),
                            child: const Text(
                              '여성',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black, // 버튼 텍스트 색상
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start, // 시작점에 맞추기
                children: <Widget>[
                  const Text(
                    '생년월일',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 250, // 버튼 가로 크기 설정
                    height: 50, // 버튼 세로 크기 설정
                    child: TextButton(
                      onPressed: () {
                        _selectDate(context); // 날짜 선택 함수 호출
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(
                              color: Color(0xFFEE8F00)), // 테두리 색상
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              formattedDate, // 포맷된 날짜를 표시
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black, // 버튼 텍스트 색상
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_drop_down, // 드롭다운 화살표 아이콘
                            color: Color(0xFFEE8F00),
                            size: 35, // 아이콘 크기 설정
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 120),
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
                builder: (context) => const PhoneNumber(),
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
