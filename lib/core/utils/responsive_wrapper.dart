import '../constants/exports.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints(
      breakpoints: const [
        Breakpoint(start: 0, end: 500, name: MOBILE),
        Breakpoint(start: 431, end: 800, name: TABLET),
        Breakpoint(start: 801, end: 1000, name: DESKTOP),
        Breakpoint(start: 1001, end: 1200, name: '4K'),
      ],
      child: child,
    );
  }

  static Widget wrapper({
    required Widget child,
    required BuildContext context,
  }) {
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaxWidthBox(
        maxWidth: 1200,
        backgroundColor: const Color(0xFFF5F5F5),
        child: ResponsiveScaledBox(
          width: ResponsiveValue<double>(
            context,
            defaultValue: 500,
            conditionalValues: [
              const Condition.equals(name: MOBILE, value: 500),
              const Condition.between(start: 501, end: 800, value: 700),
              Condition.between(
                start: 801,
                end: 1000,
                value: context.isLandscape ? 1000 : 820,
              ),
              Condition.between(
                start: 1001,
                end: 1300,
                value: context.isLandscape ? 1300 : 1020,
              ),
              Condition.between(start: 1301, end: 1600, value: 1500),
              Condition.equals(name: TABLET, value: context.width),
            ],
          ).value,
          child: ClampingScrollWrapper.builder(
            context,
            child,
            dragWithMouse: true,
          ),
        ),
      ),
    );
  }
}
