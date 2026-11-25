import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masrofy/core/utils/constants/locale_keys.g.dart';
import 'package:masrofy/core/utils/extensions/extensions.dart';
import 'package:masrofy/features/notification/data/datasources/notification_local_datasource.dart';
import 'package:masrofy/features/notification/presentation/cubit/notification_cubit.dart';
import 'package:masrofy/features/notification/presentation/cubit/notification_state.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          NotificationCubit(NotificationLocalDataSourceImpl())
            ..loadNotifications(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.notifications.tr()),
          actions: [
            BlocBuilder<NotificationCubit, NotificationState>(
              builder: (context, state) {
                if (state.notifications.isEmpty) return const SizedBox.shrink();
                return IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => context.read<NotificationCubit>().clearAll(),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            if (state.notifications.isEmpty) {
              return Center(
                child: Text(
                  LocaleKeys.no_notifications_subtitle.tr(),
                  style: context.textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: state.notifications.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = state.notifications[index];
                return ListTile(
                  tileColor: item.isRead
                      ? null
                      : Theme.of(context).colorScheme.primary
                            .withValues(alpha: 0.08),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  title: Text(
                    item.title,
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: item.isRead
                          ? FontWeight.normal
                          : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(item.body),
                  trailing: Text(
                    DateFormat('hh:mm a').format(item.createdAt),
                    style: context.textTheme.bodySmall,
                  ),
                  onTap: () =>
                      context.read<NotificationCubit>().markAsRead(item.id),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
