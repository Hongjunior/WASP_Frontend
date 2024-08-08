import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // JSON 처리
import 'config.dart'; // Config import 추가

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  bool _endConversation = false;
  late Config _config; // Config 변수 추가

  @override
  void initState() {
    super.initState();
    _config = Config(); // Config 객체 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: const Color(0xFFEE8F00),
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: Stack(
            children: <Widget>[
              Positioned(
                left: 10,
                top: 0,
                bottom: 0,
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    iconSize: 30,
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
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _formatDate(DateTime.now()), // 현재 날짜로 변경
              style: const TextStyle(
                fontSize: 12.0,
                color: Color(0xFFA1A1A1),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: _messages.map((message) {
                return _buildMessage(
                  message['text']!,
                  isMe: message['isMe'] == 'true',
                  time: message['time']!,
                );
              }).toList(),
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // 현재 날짜를 포맷팅하여 문자열로 반환
  String _formatDate(DateTime date) {
    return '- ${date.year}년 ${date.month}월 ${date.day}일 -';
  }

  // 메시지를 포맷팅하여 표시
  Widget _buildMessage(String message,
      {required bool isMe, required String time}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (!isMe) ...[
            Container(
              constraints: const BoxConstraints(
                maxWidth: 250.0,
              ),
              margin: const EdgeInsets.only(bottom: 15.0, right: 8.0),
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.zero,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                color: Color(0xFFA1A1A1),
                fontSize: 10.0,
              ),
            ),
          ] else ...[
            Text(
              time,
              style: const TextStyle(
                color: Color(0xFFA1A1A1),
                fontSize: 10.0,
              ),
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 250.0,
              ),
              margin: const EdgeInsets.only(bottom: 15.0, left: 8.0),
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                color: Color(0xFFEE8F00),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
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
      color: Colors.transparent,
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            'assets/icons/voice.svg',
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '메시지를 입력하세요',
                hintStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFFD0D0D0),
                ),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFCDCDCD),
                    width: 0.8,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFCDCDCD),
                    width: 0.8,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: (value) {
                _sendMessage(value);
              },
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 40.0,
            height: 40.0,
            decoration: const BoxDecoration(
              color: Color(0xFFEE8F00),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: () {
                _sendMessage(_controller.text);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 사용자 입력을 백엔드로 전송하고 응답을 처리하는 메서드
  Future<void> _sendMessage(String userInput) async {
    final baseUrl = _config.baseUrl; // Config에서 URL 가져오기
    final url = Uri.parse('$baseUrl/chat/'); // URL 수정

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_input': userInput,
          'end_conversation': _endConversation,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _messages.add({
            'text': userInput,
            'isMe': 'true',
            'time': _formatTime(DateTime.now()),
          });
          _messages.add({
            'text': data['response'],
            'isMe': 'false',
            'time': _formatTime(DateTime.now()),
          });
        });
      } else {
        setState(() {
          _messages.add({
            'text': 'Error: ${response.reasonPhrase}',
            'isMe': 'false',
            'time': _formatTime(DateTime.now()),
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'text': 'Error: $e',
          'isMe': 'false',
          'time': _formatTime(DateTime.now()),
        });
      });
    }

    _controller.clear();
  }

  // 현재 시간을 포맷팅하여 문자열로 반환
  String _formatTime(DateTime time) {
    return '${time.hour > 12 ? '오후' : '오전'} ${time.hour % 12}:${time.minute.toString().padLeft(2, '0')}';
  }
}
