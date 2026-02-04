import '../../../../core/constants/exports.dart';

class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextInputType? keyboardType;
  final bool autoFocus;
  final VoidCallback? onClear;

  const SearchField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hintText,
    required this.onChanged,
    this.keyboardType,
    this.autoFocus = false,
    this.onClear,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;
  late final Animation<double> _fade;

  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _scale = Tween<double>(
      begin: 0.98,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    widget.focusNode.addListener(_handleFocus);
    widget.controller.addListener(() => setState(() {}));

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.focusNode.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocus);
    _controller.dispose();
    super.dispose();
  }

  void _handleFocus() {
    setState(() => _hasFocus = widget.focusNode.hasFocus);

    if (_hasFocus) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return ScaleTransition(
      scale: _scale,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        decoration: BoxDecoration(
          color: cs.outline.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            if (_hasFocus)
              BoxShadow(
                color: cs.primary.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 16),

            /// 🔍 Search icon
            Icon(
              SolarIconsOutline.magnifier,
              size: 20,
              color: _hasFocus
                  ? cs.primary
                  : cs.onSurface.withValues(alpha: 0.5),
            ),

            const SizedBox(width: 12),

            /// ✏️ Text field
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: widget.keyboardType,
                cursorColor: cs.primary,
                style: TextStyle(
                  fontSize: 15,
                  color: cs.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: cs.onSurface.withValues(alpha: 0.4),
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: widget.onChanged,
              ),
            ),

            /// ❌ Clear button or 🎤 Voice button
            widget.controller.text.isNotEmpty
                ? FadeTransition(
                    opacity: _fade,
                    child: InkWell(
                      onTap: () {
                        widget.controller.clear();
                        widget.onChanged('');
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.close_rounded,
                          size: 20,
                          color: cs.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
