// User Info View - iOS 26 Clean Style
// Displays user subscription info, traffic usage, and account details

import 'package:fl_clash/models/v2board_models.dart';
import 'package:fl_clash/providers/v2board_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class UserInfoView extends ConsumerWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final subscriptionAsync = ref.watch(userSubscriptionProvider);
    
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(currentUserProvider.notifier).fetch();
        await ref.read(userSubscriptionProvider.notifier).fetch();
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Card - combine user and subscription data
            Builder(
              builder: (context) {
                final user = userAsync.value;
                final subscription = subscriptionAsync.value;
                if (userAsync.isLoading) {
                  return const _LoadingCard();
                }
                if (userAsync.hasError) {
                  return _ErrorCard(error: userAsync.error.toString());
                }
                if (user == null) {
                  return const _EmptyCard(message: '请登录查看账户信息');
                }
                return _UserInfoCard(user: user, subscription: subscription);
              },
            ),
            const SizedBox(height: 16),
            
            // Traffic Usage Card - use subscription data which has traffic info
            subscriptionAsync.when(
              data: (sub) => sub != null 
                ? _TrafficCard(subscription: sub)
                : const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 16),
            
            // Subscription Card
            subscriptionAsync.when(
              data: (sub) => sub != null 
                ? _SubscriptionCard(subscription: sub, ref: ref)
                : const SizedBox.shrink(),
              loading: () => const _LoadingCard(),
              error: (e, _) => _ErrorCard(error: e.toString()),
            ),
            const SizedBox(height: 16),
            
            // Actions Card
            _ActionsCard(ref: ref),
          ],
        ),
      ),
    );
  }
}

class _UserInfoCard extends StatelessWidget {
  final V2BoardUser user;
  final V2BoardSubscription? subscription;
  
  const _UserInfoCard({required this.user, this.subscription});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    // Get plan name from subscription (has full data) or fallback to user
    final planName = subscription?.plan?.name ?? user.plan?.name;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer,
            colorScheme.primaryContainer.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Avatar
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 28,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.email ?? '用户',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onPrimaryContainer,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (planName != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: user.isExpired 
                            ? colorScheme.error.withOpacity(0.2)
                            : colorScheme.primary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          planName,
                          style: textTheme.labelSmall?.copyWith(
                            color: user.isExpired 
                              ? colorScheme.error
                              : colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Expiry Info
          Row(
            children: [
              Icon(
                Icons.access_time,
                size: 16,
                color: colorScheme.onPrimaryContainer.withOpacity(0.7),
              ),
              const SizedBox(width: 8),
              Text(
                user.isExpired 
                  ? '已过期'
                  : user.expiryDate != null
                    ? '到期时间：${DateFormat('yyyy-MM-dd').format(user.expiryDate!)}'
                    : '永久有效',
                style: textTheme.bodySmall?.copyWith(
                  color: user.isExpired 
                    ? colorScheme.error
                    : colorScheme.onPrimaryContainer.withOpacity(0.8),
                ),
              ),
              const Spacer(),
              if (user.daysUntilExpiry != null && !user.isExpired)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '剩余 ${user.daysUntilExpiry} 天',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrafficCard extends StatelessWidget {
  final V2BoardSubscription subscription;
  
  const _TrafficCard({required this.subscription});

  String _formatTraffic(int bytes) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    int unitIndex = 0;
    double value = bytes.toDouble();
    while (value >= 1024 && unitIndex < units.length - 1) {
      value /= 1024;
      unitIndex++;
    }
    return '${value.toStringAsFixed(2)} ${units[unitIndex]}';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    final uploadTraffic = subscription.uploadTraffic ?? 0;
    final downloadTraffic = subscription.downloadTraffic ?? 0;
    final usedTraffic = uploadTraffic + downloadTraffic;
    final totalTraffic = subscription.transferEnable ?? 0;
    final usagePercent = totalTraffic > 0 ? (usedTraffic / totalTraffic * 100).clamp(0.0, 100.0) : 0.0;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.data_usage,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                '流量使用',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: (usagePercent / 100).clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: colorScheme.surfaceContainerHighest,
              valueColor: AlwaysStoppedAnimation<Color>(
                usagePercent > 90 
                  ? colorScheme.error
                  : colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 12),
          
          // Traffic Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '已使用',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    _formatTraffic(usedTraffic),
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '总量',
                    style: textTheme.labelSmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    _formatTraffic(totalTraffic),
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Upload/Download
          Row(
            children: [
              Icon(
                Icons.arrow_upward,
                size: 14,
                color: colorScheme.tertiary,
              ),
              const SizedBox(width: 4),
              Text(
                '上传 ${_formatTraffic(uploadTraffic)}',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 16),
              Icon(
                Icons.arrow_downward,
                size: 14,
                color: colorScheme.secondary,
              ),
              const SizedBox(width: 4),
              Text(
                '下载 ${_formatTraffic(downloadTraffic)}',
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final V2BoardSubscription subscription;
  final WidgetRef ref;
  
  const _SubscriptionCard({
    required this.subscription,
    required this.ref,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.link,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                '订阅链接',
                style: textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Action Button - Copy only
          OutlinedButton.icon(
            onPressed: () {
              if (subscription.subscribeUrl != null) {
                Clipboard.setData(
                  ClipboardData(text: subscription.subscribeUrl!),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('订阅链接已复制'),
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            icon: const Icon(Icons.copy, size: 16),
            label: const Text('复制链接'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  String _maskUrl(String url) {
    if (url.length < 30) return url;
    return '${url.substring(0, 20)}...${url.substring(url.length - 10)}';
  }
}

class _ActionsCard extends StatelessWidget {
  final WidgetRef ref;
  
  const _ActionsCard({required this.ref});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.logout, color: colorScheme.primary),
            title: Text(
              '退出登录',
              style: TextStyle(color: colorScheme.primary),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onTap: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('退出登录'),
                  content: const Text('确定要退出当前账号吗？'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('取消'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: FilledButton.styleFrom(
                        backgroundColor: colorScheme.error,
                      ),
                      child: const Text('退出'),
                    ),
                  ],
                ),
              );
              if (confirm == true) {
                await ref.read(loginActionProvider.notifier).logout();
              }
            },
          ),
        ],
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  final String error;
  
  const _ErrorCard({required this.error});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.errorContainer.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colorScheme.error),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              error,
              style: TextStyle(color: colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyCard extends StatelessWidget {
  final String message;
  
  const _EmptyCard({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          message,
          style: textTheme.bodyMedium?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
