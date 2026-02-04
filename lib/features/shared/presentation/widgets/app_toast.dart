import 'package:flash/flash.dart';
import '../../../../core/constants/exports.dart';
import '../../../../core/utils/app_border_radius.dart';
import '../../../../core/utils/app_padding.dart';
import 'app_text.dart';

class AppToast {
  static void showError({
    required String message,
    required BuildContext context,
  }) {
    _showCustomToast(
      context: context,
      content: message,
      boxColor: context.colorScheme.error,
    );
  }

  static void showSuccess({
    required String message,
    required BuildContext context,
  }) {
    _showCustomToast(
      context: context,
      content: message,
      boxColor: context.colorScheme.primary,
    );
  }

  static void showCopy({
    required String message,
    required BuildContext context,
  }) {
    _showCustomToast(
      context: context,
      content: message,
      duration: Duration(milliseconds: 1500),
      boxColor: context.colorScheme.surfaceContainerLow,
    );
  }

  static void showInfo({
    required String message,
    required BuildContext context,
  }) {
    _showCustomToast(
      context: context,
      content: message,
      boxColor: context.colorScheme.primary.withValues(alpha: 0.4),
      fontWeight: FontWeight.w600,
      fontSize: 14,
      hideDismissIcon: true,
      dismissDirections: [FlashDismissDirection.endToStart],
      mainAxisAlignment: MainAxisAlignment.center,
      flashPosition: FlashPosition.top,
      duration: Duration(seconds: 4),
      onBuild: (controller) {
        controller.dismiss();
      },
    );
  }

  static Future<Object?> _showCustomToast({
    required BuildContext context,
    required String content,
    required Color boxColor,
    Function(FlashController controller)? onBuild,
    Duration? duration,
    FlashPosition? flashPosition,
    MainAxisAlignment? mainAxisAlignment,
    FontWeight? fontWeight,
    double? fontSize,
    bool hideDismissIcon = false,
    List<FlashDismissDirection>? dismissDirections,
  }) {
    return showFlash(
      barrierDismissible: true,
      context: context,
      persistent: true,
      transitionDuration: const Duration(milliseconds: 400),
      duration: duration ?? const Duration(seconds: 4),
      builder: (context, controller) {
        if (onBuild != null) onBuild(controller);
        return Column(
          mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
          children: [
            Flash(
              position: flashPosition ?? FlashPosition.bottom,
              dismissDirections:
                  dismissDirections ?? const [FlashDismissDirection.endToStart],
              controller: controller,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: boxColor,
                  borderRadius: AppBorderRadius.set(all: 12.0),
                ),
                padding: const AppPadding.set(vertical: 12.0, start: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: AppText(
                        content,
                        weight: fontWeight ?? FontWeight.w400,
                        size: fontSize ?? 16,
                        color: context.colorScheme.onSurface,
                        maxLines: 5,
                        autoSized: true,
                      ).addPadding(end: hideDismissIcon ? 0 : 21.0),
                    ),
                    if (!hideDismissIcon)
                      Icon(
                        Icons.clear,
                        color: context.colorScheme.onSurface,
                        size: 16.0,
                      ).addAction(
                        padding: const AppPadding.set(horizontal: 12.0),
                        onBounce: () => controller.dismiss(),
                      ),
                  ],
                ),
              ),
            ).addPadding(top: 80.0, bottom: 50.0, horizontal: 21),
          ],
        );
      },
    );
  }
}
