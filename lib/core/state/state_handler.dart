import 'package:tmda/features/shared/presentation/widgets/app_error_state.dart';

import '../../features/shared/presentation/widgets/app_loading.dart';
import '../constants/exports.dart';
import 'app_state.dart';

class StateHandler extends StatefulWidget {
  final AppState state;
  final Widget? initialWidget,
      loadingWidget,
      loadingOverlayWidget,
      failureWidget;
  final Function()? onSuccess, onFailure, onLoading;
  final Function(BuildContext context, AppState state) builder;
  final Function()? onRetry;

  const StateHandler({
    super.key,
    required this.state,
    required this.builder,
    this.initialWidget,
    this.loadingWidget,
    this.failureWidget,
    this.loadingOverlayWidget,
    this.onSuccess,
    this.onFailure,
    this.onLoading,
    this.onRetry,
  });

  @override
  State<StateHandler> createState() => _StateHandlerState();
}

class _StateHandlerState extends State<StateHandler> {
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;

    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black54,
        child: Center(
          child:
              widget.loadingOverlayWidget ??
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const CircularProgressIndicator(),
              ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    // Check overlay status and manage overlay
    if (widget.state.status == StateStatus.loadingOverlay) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showOverlay();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _removeOverlay();
      });
    }

    // Handle callbacks
    WidgetsBinding.instance.addPostFrameCallback((_) {
      switch (widget.state.status) {
        case StateStatus.none:
          break;
        case StateStatus.success:
          widget.onSuccess?.call();
          break;
        case StateStatus.error:
          widget.onFailure?.call();
          break;
        case StateStatus.loading:
        case StateStatus.loadingOverlay:
          widget.onLoading?.call();
          break;
        default:
          break;
      }
    });

    // Build UI based on state
    switch (widget.state.status) {
      case StateStatus.none:
        return const SizedBox.shrink();
      case StateStatus.initial:
        return widget.initialWidget ?? const SizedBox.shrink();
      case StateStatus.loading:
        return widget.loadingWidget ?? Center(child: Loading.loader(context));
      case StateStatus.loadingOverlay:
      case StateStatus.success:
        return widget.builder(context, widget.state);
      case StateStatus.error:
        return widget.failureWidget ??
            AppErrorState(
              message: widget.state.message,
              onPressed: widget.onRetry,
            );
    }
  }
}
