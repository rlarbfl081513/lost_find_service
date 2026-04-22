import 'package:client/organisms/modals/two_button_modal.dart';
import 'package:flutter/material.dart';
import 'package:client/templates/pickup/pickup_tracking_page_template.dart';
import 'package:client/organisms/modals/identity_verification_modal.dart';

class PickupTrackingPage extends StatefulWidget {
  const PickupTrackingPage({super.key});

  @override
  State<PickupTrackingPage> createState() => _PickupTrackingPageState();
}

class _PickupTrackingPageState extends State<PickupTrackingPage> {
  double _progress = 0.3; // 진행률 (0.0 ~ 1.0)
  final double _scale = 1.0; // 드래그에 따른 크기 변화

  // 로봇과 스팟 위치 (실제로는 API에서 받아올 데이터)
  final Offset _robotPosition = Offset(0.3, 0.6); // 화면의 30%, 60% 위치
  final Offset _spotPosition = Offset(0.7, 0.4); // 화면의 70%, 40% 위치

  @override
  Widget build(BuildContext context) {
    return PickupTrackingPageTemplate(
      estimatedTime: "15",
      robotLocation: "서울특별시 강남구 테헤란로 123",
      itemName: "아이폰 15 Pro Max",

      // 이벤트 핸들러들
      onBackPressed: () => Navigator.pop(context),
      onPickupCompleted: _onPickupCompleted,
      onPickupCancelled: _onPickupCancelled,
      onSpotChanged: _onSpotChanged,
      robotPosition: _robotPosition,
      spotPosition: _spotPosition,
      progress: _progress,
      scale: _scale,
      onMapTap: _onMapTap,
    );
  }

  // onMapTap
  void _onMapTap() {
    print('지도 탭됨');
  }

  // 수령 완료
  void _onPickupCompleted() {
    print('물건 수령 신청!');
    // 본인확인 모달 표시
    showDialog(
      context: context,
      barrierDismissible: false, // 배경 탭으로 닫기 방지
      builder: (BuildContext context) {
        return IdentityVerificationModal(
          onCancel: () {
            Navigator.of(context).pop(); // 모달 닫기
          },
        );
      },
    );

    // 3초후 모달 닫기
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return TwoButtonModal(
            title: '보관함에서 물건을 꺼내 확인하세요.\n아맞다님의 물건이 맞나요?',
            onLeftButtonPressed: _onItemCheckCancelled,
            leftButtonText: '어..아니에요',
            onRightButtonPressed: _onItemCheckCompleted,
            rightButtonText: '네 가져갈게요',
          );
        },
      );
    });
  }

  void _onItemCheckCompleted() {
    print('물건 확인 완료');
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TwoButtonModal(
          title: '아맞다님 물건을 찾으셨군요!\n축하드려요!!!',
          onLeftButtonPressed: () {
            Navigator.of(context).pop();
          },
          leftButtonText: '돌아가기',
          onRightButtonPressed: () {
            Navigator.of(context).pop();
          },
          rightButtonText: '확인',
        );
      },
    );
  }

  void _onItemCheckCancelled() {
    print('물건 확인 취소');
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TwoButtonModal(
          title: '아맞다님 물건이 아니군요!\n요기입에 물건을 넣어주세요.',
          onLeftButtonPressed: () {
            Navigator.of(context).pop();
          },
          leftButtonText: '돌아가기',
          onRightButtonPressed: () {
            Navigator.of(context).pop();
          },
          rightButtonText: '확인',
        );
      },
    );
  }

  // 수령 취소
  void _onPickupCancelled() {
    print('수령 취소됨');
    // TODO: 수령 취소 로직 구현
    Navigator.pop(context);
  }

  // 스팟 변경
  void _onSpotChanged() {
    print('스팟 변경 요청');
    // TODO: 스팟 변경 페이지로 이동
    Navigator.pushNamed(context, '/pickup-select');
  }

  // 진행률 업데이트 (실제로는 타이머나 웹소켓으로 실시간 업데이트)
  void _updateProgress() {
    setState(() {
      _progress += 0.01;
      if (_progress > 1.0) {
        _progress = 1.0;
      }
    });
  }

  // 드래그에 따른 크기 변화 업데이트
  // void _updateScale(double scale) {
  //   setState(() {
  //     _scale = scale;
  //   });
  // }
}
