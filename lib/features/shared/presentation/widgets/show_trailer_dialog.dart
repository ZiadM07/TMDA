import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';
import 'app_toast.dart';

/// Opens a YouTube trailer dialog.
/// - Player is created lazily
/// - Fullscreen is handled deterministically
/// - Orientation is always restored
Future<void> showTrailerDialog(
  BuildContext context, {
  required String youtubeKey,
}) async {
  if (youtubeKey.isEmpty) {
    AppToast.showCopy(
      message: context.locale.noTrailerAvailable,
      context: context,
    );
    return;
  }

  final videoId = YoutubePlayer.convertUrlToId(youtubeKey) ?? youtubeKey;

  final controller = YoutubePlayerController(
    initialVideoId: videoId,
    flags: const YoutubePlayerFlags(
      autoPlay: true,
      mute: false,
      enableCaption: true,
      controlsVisibleAtStart: true,
    ),
  );

  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierColor: Colors.black87,
    barrierLabel: context.locale.trailer,
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (_, __, ___) {
      return _TrailerDialog(controller: controller);
    },
    transitionBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
        child: child,
      );
    },
  );

  controller.dispose();

  // Always restore UI state
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
}

// ============================================================================
// DIALOG
// ============================================================================

class _TrailerDialog extends StatefulWidget {
  final YoutubePlayerController controller;

  const _TrailerDialog({required this.controller});

  @override
  State<_TrailerDialog> createState() => _TrailerDialogState();
}

class _TrailerDialogState extends State<_TrailerDialog> {
  bool _isFullScreen = false;
  bool _isReady = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onPlayerChanged);
  }

  void _onPlayerChanged() {
    if (!mounted) return;

    final value = widget.controller.value;

    if (value.isReady && !_isReady) {
      setState(() => _isReady = true);
    }

    if (value.hasError && !_hasError) {
      _hasError = true;
      AppToast.showCopy(
        message: '${context.locale.error}: ${value.errorCode}',
        context: context,
      );
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onPlayerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;
    final size = MediaQuery.sizeOf(context);

    return PopScope(
      canPop: !_isFullScreen,
      onPopInvokedWithResult: (didPop, _) {
        // Back button exits fullscreen first
        if (_isFullScreen && !didPop) {
          widget.controller.toggleFullScreenMode();
        }
      },
      child: Center(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: _isFullScreen ? size.width : 600,
          height: _isFullScreen ? size.height : size.height * 0.8,
          margin: EdgeInsets.symmetric(
            horizontal: _isFullScreen ? 0 : 20,
            vertical: _isFullScreen ? 0 : 40,
          ),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: _isFullScreen ? null : BorderRadius.circular(24),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              if (!_isFullScreen) _Header(cs),
              Expanded(child: _buildPlayer(cs)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlayer(ColorScheme cs) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () async {
        if (!mounted) return;

        setState(() => _isFullScreen = true);

        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      },
      onExitFullScreen: () async {
        if (!mounted) return;

        setState(() => _isFullScreen = false);

        await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      },
      player: YoutubePlayer(
        controller: widget.controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: cs.primary,
        progressColors: ProgressBarColors(
          playedColor: cs.primary,
          bufferedColor: cs.primary.withValues(alpha: .3),
          handleColor: cs.primary,
          backgroundColor: Colors.white24,
        ),
        topActions: [
          const SizedBox(width: 8),
          Expanded(
            child: AppText(
              widget.controller.metadata.title,
              size: 14,
              weight: FontWeight.w600,
              color: Colors.white,
              maxLines: 1,
            ),
          ),
        ],
      ),
      builder: (_, player) {
        return Stack(
          alignment: Alignment.center,
          children: [
            player,

            if (!_isReady && !_hasError)
              const IgnorePointer(child: CircularProgressIndicator()),

            if (_hasError)
              const Icon(Icons.error_outline, size: 48, color: Colors.white70),
          ],
        );
      },
    );
  }
}

// ============================================================================
// HEADER
// ============================================================================

class _Header extends StatelessWidget {
  final ColorScheme cs;

  const _Header(this.cs);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [cs.primary.withValues(alpha: 0.1), cs.surface],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.play_circle_outline, color: cs.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: AppText(
              context.locale.watchTrailer,
              size: 18,
              weight: FontWeight.bold,
              color: cs.onSurface,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close_rounded, color: cs.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
