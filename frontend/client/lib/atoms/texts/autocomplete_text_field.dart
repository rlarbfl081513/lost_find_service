import 'package:flutter/material.dart';
import 'package:client/core/services/autocomplete_service.dart';

/// 자동완성 기능이 포함된 텍스트 필드 위젯
class AutocompleteTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function(String)? onSuggestionSelected;
  final int maxSuggestions;
  final bool enabled;
  final InputDecoration? decoration;
  final TextStyle? style;
  final TextStyle? suggestionStyle;
  final Color? suggestionBackgroundColor;
  final Color? suggestionTextColor;
  final double suggestionHeight;
  final BorderRadius? suggestionBorderRadius;
  final EdgeInsets? suggestionPadding;

  const AutocompleteTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSuggestionSelected,
    this.maxSuggestions = 10,
    this.enabled = true,
    this.decoration,
    this.style,
    this.suggestionStyle,
    this.suggestionBackgroundColor,
    this.suggestionTextColor,
    this.suggestionHeight = 50.0,
    this.suggestionBorderRadius,
    this.suggestionPadding,
  });

  @override
  State<AutocompleteTextField> createState() => _AutocompleteTextFieldState();
}

class _AutocompleteTextFieldState extends State<AutocompleteTextField> {
  late TextEditingController _controller;
  List<String> _suggestions = [];
  bool _showSuggestions = false;
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      _hideSuggestions();
    }
  }

  void _onTextChanged(String text) {
    if (text.isEmpty) {
      _hideSuggestions();
      widget.onChanged?.call(text);
      return;
    }

    // 자동완성 검색
    final suggestions = AutocompleteService.instance.search(text);

    setState(() {
      _suggestions = suggestions.take(widget.maxSuggestions).toList();
      _showSuggestions = _suggestions.isNotEmpty;
    });

    // 오버레이 업데이트
    if (_showSuggestions) {
      _showOverlay();
    } else {
      _hideSuggestions();
    }

    widget.onChanged?.call(text);
  }

  void _showOverlay() {
    _removeOverlay();

    if (!_showSuggestions || _suggestions.isEmpty) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.9,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 50), // 텍스트 필드 아래에 표시
          child: Material(
            elevation: 4.0,
            borderRadius:
                widget.suggestionBorderRadius ?? BorderRadius.circular(8.0),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: widget.suggestionHeight * _suggestions.length,
              ),
              decoration: BoxDecoration(
                color: widget.suggestionBackgroundColor ?? Colors.white,
                borderRadius:
                    widget.suggestionBorderRadius ?? BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: ListView.builder(
                padding: widget.suggestionPadding ?? EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = _suggestions[index];
                  return ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    title: Text(
                      suggestion,
                      style:
                          widget.suggestionStyle ??
                          const TextStyle(fontSize: 16.0),
                    ),
                    onTap: () => _onSuggestionSelected(suggestion),
                    hoverColor: Colors.grey.shade100,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _hideSuggestions() {
    setState(() {
      _showSuggestions = false;
    });
    _removeOverlay();
  }

  void _onSuggestionSelected(String suggestion) {
    _controller.text = suggestion;
    _controller.selection = TextSelection.fromPosition(
      TextPosition(offset: suggestion.length),
    );
    _hideSuggestions();
    _focusNode.unfocus();

    widget.onSuggestionSelected?.call(suggestion);
    widget.onChanged?.call(suggestion);
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        enabled: widget.enabled,
        style: widget.style,
        onChanged: _onTextChanged,
        onSubmitted: widget.onSubmitted,
        decoration:
            widget.decoration ??
            InputDecoration(
              hintText: widget.hintText,
              labelText: widget.labelText,
              border: const OutlineInputBorder(),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
            ),
      ),
    );
  }
}

/// 간단한 자동완성 텍스트 필드 (오버레이 없이 드롭다운 형태)
class SimpleAutocompleteTextField extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function(String)? onSuggestionSelected;
  final int maxSuggestions;
  final bool enabled;
  final InputDecoration? decoration;
  final TextStyle? style;

  const SimpleAutocompleteTextField({
    super.key,
    this.hintText,
    this.labelText,
    this.controller,
    this.onChanged,
    this.onSubmitted,
    this.onSuggestionSelected,
    this.maxSuggestions = 5,
    this.enabled = true,
    this.decoration,
    this.style,
  });

  @override
  State<SimpleAutocompleteTextField> createState() =>
      _SimpleAutocompleteTextFieldState();
}

class _SimpleAutocompleteTextFieldState
    extends State<SimpleAutocompleteTextField> {
  late TextEditingController _controller;
  List<String> _suggestions = [];
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(String text) {
    if (text.isEmpty) {
      setState(() {
        _suggestions = [];
        _showSuggestions = false;
      });
      widget.onChanged?.call(text);
      return;
    }

    // 자동완성 검색
    final suggestions = AutocompleteService.instance.search(text);

    setState(() {
      _suggestions = suggestions.take(widget.maxSuggestions).toList();
      _showSuggestions = _suggestions.isNotEmpty;
    });

    widget.onChanged?.call(text);
  }

  void _onSuggestionSelected(String suggestion) {
    _controller.text = suggestion;
    setState(() {
      _showSuggestions = false;
    });

    widget.onSuggestionSelected?.call(suggestion);
    widget.onChanged?.call(suggestion);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          enabled: widget.enabled,
          style: widget.style,
          onChanged: _onTextChanged,
          onSubmitted: widget.onSubmitted,
          decoration:
              widget.decoration ??
              InputDecoration(
                hintText: widget.hintText,
                labelText: widget.labelText,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
              ),
        ),
        if (_showSuggestions && _suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                final suggestion = _suggestions[index];
                return ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  title: Text(
                    suggestion,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  onTap: () => _onSuggestionSelected(suggestion),
                  hoverColor: Colors.grey.shade100,
                );
              },
            ),
          ),
      ],
    );
  }
}
