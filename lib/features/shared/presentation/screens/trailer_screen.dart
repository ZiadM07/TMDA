import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';
import 'package:tmda/features/shared/presentation/widgets/app_toast.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage()
class TrailerScreen extends StatefulWidget {
  final String youtubeKey;
  final String? title;

  const TrailerScreen({super.key, required this.youtubeKey, this.title});

  @override
  State<TrailerScreen> createState() => _TrailerScreenState();
}

class _TrailerScreenState extends State<TrailerScreen> {
  late YoutubePlayerController _controller;
  bool _isFullScreen = false;
  bool _isReady = false;
  bool _hasError = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    final videoId =
        YoutubePlayer.convertUrlToId(widget.youtubeKey) ?? widget.youtubeKey;

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: true,
        controlsVisibleAtStart: true,
        hideControls: false,
      ),
    );

    _controller.addListener(_onPlayerChanged);
    setState(() => _isInitialized = true);
  }

  void _onPlayerChanged() {
    if (!mounted) return;

    final value = _controller.value;

    if (value.isReady && !_isReady) {
      setState(() => _isReady = true);
    }

    if (value.hasError && !_hasError) {
      setState(() => _hasError = true);
      AppToast.showCopy(
        message: '${context.locale.error}: ${value.errorCode}',
        context: context,
      );
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onPlayerChanged);
    _controller.dispose();

    // Restore orientation and system UI
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = context.colorScheme;

    return PopScope(
      canPop: !_isFullScreen,
      onPopInvokedWithResult: (didPop, _) {
        if (_isFullScreen && !didPop) {
          _controller.toggleFullScreenMode();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              if (!_isFullScreen) _buildHeader(cs),
              Expanded(child: _buildPlayer(cs)),
              if (!_isFullScreen && _isReady) _buildVideoInfo(cs),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: AppText(
              widget.title ?? context.locale.watchTrailer,
              size: 16,
              weight: FontWeight.w600,
              color: Colors.white,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 48), // Balance the back button
        ],
      ),
    );
  }

  Widget _buildPlayer(ColorScheme cs) {
    if (!_isInitialized) {
      return const Center(
        child: CircularProgressIndicator(color: Colors.white),
      );
    }

    return YoutubePlayerBuilder(
      onEnterFullScreen: () async {
        if (!mounted) return;

        setState(() => _isFullScreen = true);

        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);

        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      },
      onExitFullScreen: () async {
        if (!mounted) return;

        setState(() => _isFullScreen = false);

        await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: cs.primary,
        progressColors: ProgressBarColors(
          playedColor: cs.primary,
          bufferedColor: cs.primary.withValues(alpha: 0.3),
          handleColor: cs.primary,
          backgroundColor: Colors.white24,
        ),
        aspectRatio: 16 / 9,
        topActions: _isFullScreen
            ? [
                const SizedBox(width: 8),
                Expanded(
                  child: AppText(
                    _controller.metadata.title,
                    size: 14,
                    weight: FontWeight.w600,
                    color: Colors.white,
                    maxLines: 1,
                  ),
                ),
              ]
            : null,
      ),
      builder: (context, player) {
        return Container(
          color: Colors.black,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(child: player),

              // Loading indicator
              if (!_isReady && !_hasError)
                const IgnorePointer(
                  child: CircularProgressIndicator(color: Colors.white),
                ),

              // Error indicator
              if (_hasError)
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.white70),
                    SizedBox(height: 16),
                    AppText(
                      'Failed to load video',
                      size: 16,
                      color: Colors.white70,
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVideoInfo(ColorScheme cs) {
    return AnimatedOpacity(
      opacity: _isReady ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (_controller.metadata.title.isNotEmpty) ...[
              AppText(
                _controller.metadata.title,
                size: 18,
                weight: FontWeight.bold,
                color: Colors.white,
                maxLines: 2,
              ),
              const SizedBox(height: 8),
            ],
            if (_controller.metadata.author.isNotEmpty)
              AppText(
                _controller.metadata.author,
                size: 14,
                color: Colors.white70,
                maxLines: 1,
              ),
          ],
        ),
      ),
    );
  }
}
