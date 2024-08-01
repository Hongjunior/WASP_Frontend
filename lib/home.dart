import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'bottom_navigation.dart';
import 'add_event.dart'; // AddEventScreen을 임포트

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  Map<DateTime, List<String>> events = {};

  @override
  void initState() {
    super.initState();
    // 초기화 작업, 필요한 경우 이벤트를 여기에 추가
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });
  }

  void _addEvent(String event) {
    setState(() {
      if (events[_selectedDate] == null) {
        events[_selectedDate] = [];
      }
      events[_selectedDate]!.add(event);
    });
  }

  void _showAddEventDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddEventScreen(
          selectedDate: _selectedDate,
          onEventAdded: (event) {
            _addEvent(event);
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ko_KR', null);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0)
            .copyWith(top: 15.0, bottom: 15.0), // 좌우 여백 80, 상하 여백 15
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30),
            Expanded(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // 이미지와 텍스트를 왼쪽에 붙이기 위해 Column을 사용
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            text: '   반가워요 ',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // 기본 텍스트 색상
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '장말벗',
                                style: TextStyle(
                                  color: Color(0xFFEE8F00), // 주황색
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '님!\n   오늘 기분은 어떠신가요?',
                                style: TextStyle(
                                  color: Colors.black, // 검정색
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Image.asset(
                        'assets/icons/logo1.png',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: TableCalendar(
                      locale: 'ko_KR', // 한국어 설정
                      firstDay: DateTime.utc(2020, 1, 1),
                      lastDay: DateTime.utc(2030, 12, 31),
                      focusedDay: DateTime.now(),
                      calendarFormat: CalendarFormat.month,
                      onDaySelected: _onDaySelected,
                      selectedDayPredicate: (date) =>
                          isSameDay(date, _selectedDate),
                      headerStyle: HeaderStyle(
                        titleCentered: true, // 제목을 중앙에 배치
                        formatButtonVisible: false,
                        leftChevronIcon: const Icon(Icons.chevron_left,
                            color: Color(0xFFEE8F00)),
                        rightChevronIcon: const Icon(Icons.chevron_right,
                            color: Color(0xFFEE8F00)),
                        titleTextFormatter: (date, locale) =>
                            DateFormat.yMMMM(locale).format(date),
                        titleTextStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      calendarStyle: const CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Color(0xFFEE8F00),
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Color(0xFFFFCC16),
                          shape: BoxShape.circle,
                        ),
                        outsideDaysVisible: false,
                        weekendTextStyle: TextStyle(color: Color(0xFFEE8F00)),
                      ),
                      daysOfWeekStyle: const DaysOfWeekStyle(
                        weekendStyle: TextStyle(
                            color: Color(0xFFEE8F00),
                            fontWeight: FontWeight.bold),
                        weekdayStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      daysOfWeekHeight: 30.0, // 요일 높이 설정
                    ),
                  ),
                  Container(
                    width: double.infinity, // 버튼이 가로로 꽉 차게
                    height: 80,
                    padding: const EdgeInsets.all(8.0), // 박스 내부 여백
                    decoration: BoxDecoration(
                      color: const Color(0xFFEE8F00), // 박스 배경색
                      borderRadius: BorderRadius.circular(10.0), // 박스 모서리 둥글기
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft, // 왼쪽 정렬
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat.yMMMd().format(_selectedDate),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 5),
                          ...?events[_selectedDate]?.map((event) => Text(
                                event,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10), // 일정 박스와 버튼 사이의 간격
                  SizedBox(
                    width: double.infinity, // 버튼이 가로로 꽉 차게
                    child: ElevatedButton(
                      onPressed: _showAddEventDialog, // 모달 팝업 호출
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFCC16), // 버튼 배경색
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(10.0), // 버튼 모서리 둥글기
                        ),
                        minimumSize: const Size.fromHeight(40), // 버튼 높이 설정
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0), // 버튼 내부 여백
                      ),
                      child: const Text(
                        '일정 추가하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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
      bottomNavigationBar: const BottomNavigator(currentIndex: 0),
    );
  }
}
