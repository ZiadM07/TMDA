import 'package:tmda/config/router/app_router.gr.dart';
import 'package:tmda/core/constants/exports.dart';
import 'package:tmda/core/framework/kprint.dart';
import 'package:tmda/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:tmda/features/profile/domain/entities/profile.dart';
import 'package:tmda/features/shared/presentation/widgets/app_image.dart';
import 'package:tmda/features/shared/presentation/widgets/app_text.dart';
import 'package:tmda/features/shared/presentation/widgets/logout_confirmation_dialog.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;
  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          borderRadius: 100,
          imageUrl: '${AppConstants.gravatarUrl}${profile.avatarPath}',
        ),
        const SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              profile.name.isNotEmpty ? profile.name : "No Account Name",
              style: context.textTheme.titleMedium,
              align: TextAlign.start,
            ),
            AppText(
              profile.username.isNotEmpty ? profile.username : '-',
              style: context.textTheme.bodyMedium,
              align: TextAlign.start,
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () {
            LogoutConfirmationDialog.show(
              context: context,
              title: context.locale.logout,
              content: context.locale.areYouSureYouWantToLogout,
              onConfirm: () async {
                kPrint('Logout confirmed');
                await context.read<AuthCubit>().logout();
                if (!context.mounted) return;
                context.replaceRoute(const UnauthenticatedRoutes());
              },
            );
          },
          icon: Icon(SolarIconsOutline.logout_2, size: 26),
        ),
      ],
    ).addPadding(horizontal: 20, top: 80);
  }
}
