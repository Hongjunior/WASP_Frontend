import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // AppBar 높이 설정
        child: AppBar(
          backgroundColor: const Color(0xFFEE8F00), // AppBar 배경색 설정
          elevation: 0, // 그림자 제거
          automaticallyImplyLeading: false, // 기본 뒤로 가기 아이콘을 제거
          flexibleSpace: Stack(
            children: <Widget>[
              Positioned(
                left: 10, // 왼쪽 여백 설정
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white, // 뒤로 가기 버튼 아이콘 색상 설정
                    iconSize: 30, // 아이콘 크기 설정
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              const Center(
                child: Text(
                  '말벗이',
                  style: TextStyle(
                    color: Colors.white, // 제목 글씨 색상 설정
                    fontSize: 20.0, // 글씨 크기 설정
                    fontWeight: FontWeight.bold, // 볼드체 설정
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 중앙 정렬
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(16.0), // 상단 여백 설정
            child: Text(
              '- 2024년 8월 1일 -',
              style: TextStyle(
                fontSize: 12.0, // 글씨 크기 설정
                color: Color(0xFFA1A1A1), // 글씨 색상 설정
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                _buildMessage('오늘 기분은 어떠세요?', isMe: false, time: '오전 10:00'),
                _buildMessage('오늘 기분이야 뭐 똑같지', isMe: true, time: '오전 10:05'),
                _buildMessage('오늘은 어떤 노래로 하루를 시작하셨나요?',
                    isMe: false, time: '오후 10:10'),
                _buildMessage('임영웅의 사랑은 늘 도망가', isMe: true, time: '오후 10:15'),
                _buildMessage('그 노래 좋죠!\n어떤 드라마에 나온 노래였죠?',
                    isMe: false, time: '오후 10:20'),
                // 추가적인 대화 내용을 여기에 추가
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // 대화 메시지를 빌드하는 메서드
  Widget _buildMessage(String message,
      {required bool isMe, required String time}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (!isMe) ...[
            // 상대방 메시지 박스
            Container(
              constraints: const BoxConstraints(
                maxWidth: 250.0, // 가로 넓이 고정
              ),
              margin: const EdgeInsets.only(
                  bottom: 15.0, right: 8.0), // 하단 여백 및 오른쪽 여백 설정
              padding: const EdgeInsets.all(10.0), // 상하좌우 여백 설정
              decoration: const BoxDecoration(
                color: Color(0xFFEEEEEE), // 대화 박스 색상 설정
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.zero,
                ), // 모서리 둥글기 설정
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.black, // 글씨 색상 설정
                      fontSize: 16.0, // 글씨 크기 설정
                      fontWeight: FontWeight.bold, // 볼드체 설정
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                color: Color(0xFFA1A1A1), // 시간 글씨 색상 설정
                fontSize: 10.0, // 시간 글씨 크기 설정
              ),
            ),
          ] else ...[
            Text(
              time,
              style: const TextStyle(
                color: Color(0xFFA1A1A1), // 시간 글씨 색상 설정
                fontSize: 10.0, // 시간 글씨 크기 설정
              ),
            ),
            // 사용자 메시지 박스
            Container(
              constraints: const BoxConstraints(
                maxWidth: 250.0, // 가로 넓이 고정
              ),
              margin: const EdgeInsets.only(
                  bottom: 15.0, left: 8.0), // 하단 여백 및 왼쪽 여백 설정
              padding: const EdgeInsets.all(10.0), // 상하좌우 여백 설정
              decoration: const BoxDecoration(
                color: Color(0xFFEE8F00), // 대화 박스 색상 설정
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(20.0),
                ), // 모서리 둥글기 설정
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white, // 글씨 색상 설정
                      fontSize: 16.0, // 글씨 크기 설정
                      fontWeight: FontWeight.bold, // 볼드체 설정
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // 대화 입력창을 빌드하는 메서드
  Widget _buildMessageInput() {
    return Container(
      height: 70.0,
      color: Colors.transparent, // 배경색을 투명으로 설정
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          // 왼쪽의 음성 버튼
          SvgPicture.asset(
            'assets/icons/voice.svg',
          ),
          const SizedBox(width: 10.0), // 버튼과 입력창 사이의 간격

          // 입력창
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: '메시지를 입력하세요',
                hintStyle: const TextStyle(
                  fontSize: 15.0, // 힌트 텍스트 글씨 크기 설정
                  color: Color(0xFFD0D0D0), // 힌트 텍스트 색상 설정
                ),
                border: InputBorder.none, // 기본 테두리 제거
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // 입력창 모서리 둥글기 설정
                  borderSide: const BorderSide(
                    color: Color(0xFFCDCDCD), // 테두리 색상 설정
                    width: 0.8, // 테두리 두께 설정
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // 입력창 모서리 둥글기 설정
                  borderSide: const BorderSide(
                    color: Color(0xFFCDCDCD), // 포커스 시 테두리 색상 설정
                    width: 0.8, // 테두리 두께 설정
                  ),
                ),
                filled: true,
                fillColor: Colors.white, // 입력창 배경색 설정
              ),
            ),
          ),
          const SizedBox(width: 10.0), // 입력창과 전송 버튼 사이의 간격

          // 전송 버튼
          Container(
            width: 40.0,
            height: 40.0,
            decoration: const BoxDecoration(
              color: Color(0xFFEE8F00), // 배경 색상 설정
              shape: BoxShape.circle, // 원형으로 설정
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white), // 전송 버튼 아이콘
              onPressed: () {
                // 전송 버튼 클릭 시 동작을 여기에 추가
              },
            ),
          ),
        ],
      ),
    );
  }
}
