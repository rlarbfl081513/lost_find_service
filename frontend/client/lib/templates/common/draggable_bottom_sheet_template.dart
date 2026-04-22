import 'package:client/atoms/buttons/drag_handle.dart';
import 'package:client/atoms/buttons/icon_button.dart';
import 'package:client/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DraggableBottomSheetTemplate extends StatefulWidget {
  final Widget backGroundWidget;
  final Widget body;
  final VoidCallback? onBackPressed;
  const DraggableBottomSheetTemplate({
    super.key,
    required this.backGroundWidget,
    required this.body,
    this.onBackPressed,
  });

  @override
  State<DraggableBottomSheetTemplate> createState() =>
      _DraggableBottomSheetTemplateState();
}

class _DraggableBottomSheetTemplateState
    extends State<DraggableBottomSheetTemplate>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _imageAnimationController;
  late Animation<double> _slideAnimation;
  late Animation<double> _imageScaleAnimation;

  bool _isExpanded = false;

  // 드래그 관련 변수
  double _dragStartY = 0;
  double _currentDragY = 0;
  bool _isDragging = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _imageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation =
        Tween<double>(
          begin: 0.2, // 초기 상태에서 20% 표시
          end: 0.95, // 최대 95%까지 확장
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        );

    _imageScaleAnimation =
        Tween<double>(
          begin: 1.0,
          end: 0.4, // 이미지가 거의 보이지 않을 정도로 축소
        ).animate(
          CurvedAnimation(
            parent: _imageAnimationController,
            curve: Curves.easeInOut,
          ),
        );

    // 초기 상태 설정 (20% 표시)
    _animationController.value = 0.0;
    _imageAnimationController.value = 0.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _imageAnimationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _animationController.forward();
      _imageAnimationController.forward();
    } else {
      _animationController.reverse();
      _imageAnimationController.reverse();
    }
  }

  void _onDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      _dragStartY = details.globalPosition.dy;
      _currentDragY = _dragStartY;
    });
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (!_isDragging) return;

    setState(() {
      _currentDragY = details.globalPosition.dy;
    });

    // 드래그 방향에 따라 애니메이션 조절
    double dragDistance = _currentDragY - _dragStartY;
    double screenHeight = MediaQuery.of(context).size.height;

    if (dragDistance < 0) {
      // 위로 드래그 (확장)
      double progress = (-dragDistance / (screenHeight * 0.3)).clamp(0.0, 1.0);
      _animationController.value = progress;
      _imageAnimationController.value = progress;
    } else {
      // 아래로 드래그 (축소)
      double progress = (1.0 - (dragDistance / (screenHeight * 0.2))).clamp(
        0.0,
        1.0,
      );
      _animationController.value = progress;
      _imageAnimationController.value = progress;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (!_isDragging) return;

    setState(() {
      _isDragging = false;
    });

    // 드래그 속도와 거리에 따라 확장/축소 결정
    double dragDistance = _currentDragY - _dragStartY;
    double velocity = details.velocity.pixelsPerSecond.dy;

    bool shouldExpand = false;

    if (velocity.abs() > 500) {
      // 빠른 드래그의 경우 속도로 판단
      shouldExpand = velocity < 0;
    } else {
      // 느린 드래그의 경우 거리로 판단
      shouldExpand = dragDistance < -50;
    }

    if (shouldExpand && !_isExpanded) {
      _toggleExpanded();
    } else if (!shouldExpand && _isExpanded) {
      _toggleExpanded();
    } else {
      // 현재 상태 유지, 애니메이션 복원
      if (_isExpanded) {
        _animationController.forward();
        _imageAnimationController.forward();
      } else {
        _animationController.reverse();
        _imageAnimationController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.gray_2,
      body: Stack(
        children: [
          // 배경 이미지 (top 고정)
          AnimatedBuilder(
            animation: _imageScaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _imageScaleAnimation.value,
                alignment: Alignment.topCenter,
                child: widget.backGroundWidget,
              );
            },
          ),
          // 뒤로가기 버튼
          Positioned(
            top: MediaQuery.of(context).padding.top + 20,
            left: 20,
            child: IconButtonAtom(
              icon: Icons.arrow_back_ios_new,
              onPressed: widget.onBackPressed,
              backgroundColor: AppColors.white,
              width: 40,
              height: 40,
            ),
          ),
          // 바텀 시트
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _slideAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - _slideAnimation.value) * 500),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: const BoxDecoration(
                      color: AppColors.gray_3,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        // 드래그 핸들
                        DragHandleAtom(
                          onTap: _toggleExpanded,
                          onPanStart: _onDragStart,
                          onPanUpdate: _onDragUpdate,
                          onPanEnd: _onDragEnd,
                        ),

                        // 상세 내용
                        Expanded(child: widget.body),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
