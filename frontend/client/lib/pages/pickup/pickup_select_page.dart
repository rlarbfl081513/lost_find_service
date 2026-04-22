import 'package:flutter/material.dart';
import 'package:client/templates/pickup/pickup_select_template.dart';

class PickupSelectPage extends StatefulWidget {
  const PickupSelectPage({super.key});

  @override
  State<PickupSelectPage> createState() => _PickupSelectPageState();
}

class _PickupSelectPageState extends State<PickupSelectPage> {
  int? selectedSpotIndex;

  // 임시 스팟 데이터
  final List<Map<String, dynamic>> spots = [
    {
      'name': '스팟 A',
      'address': '서울시 강남구 테헤란로 123',
      'time': 5,
      'position': const Offset(0.2, 0.3),
    },
    {
      'name': '스팟 B',
      'address': '서울시 강남구 역삼동 456',
      'time': 8,
      'position': const Offset(0.7, 0.4),
    },
    {
      'name': '스팟 C',
      'address': '서울시 강남구 삼성동 789',
      'time': 12,
      'position': const Offset(0.3, 0.7),
    },
    {
      'name': '스팟 D',
      'address': '서울시 강남구 청담동 321',
      'time': 15,
      'position': const Offset(0.8, 0.8),
    },
  ];

  void _onSpotSelected(int index) {
    setState(() {
      selectedSpotIndex = index;
    });
  }

  void _onConfirmPressed() {
    // 다음 페이지로 이동하는 로직 (현재는 로그만 출력)
    print('=== 수령하기 페이지 이동 로그 ===');
    print('선택된 스팟: ${spots[selectedSpotIndex!]['name']}');
    print('스팟 주소: ${spots[selectedSpotIndex!]['address']}');
    print('소요 시간: ${spots[selectedSpotIndex!]['time']}분');
    print('다음 페이지로 이동 예정...');
    print('================================');

    // TODO: 다음 페이지로 이동하는 코드 추가 예정
    // Navigator.pushNamed(context, '/next-page');
  }

  @override
  Widget build(BuildContext context) {
    return PickupSelectTemplate(
      title: "수령하기",
      onBackPressed: () => Navigator.pop(context),
      spots: spots,
      selectedSpotIndex: selectedSpotIndex,
      onSpotSelected: _onSpotSelected,
      onConfirmPressed: selectedSpotIndex != null ? _onConfirmPressed : null,
    );
  }
}
