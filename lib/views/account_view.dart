// Account View - V2Board User Dashboard
// Combines user info, notices, tickets in tabbed view

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/providers/v2board_provider.dart';
import 'package:fl_clash/views/user_info_view.dart';
import 'package:fl_clash/views/orders_view.dart';
import 'package:fl_clash/views/notices_view.dart';
import 'package:fl_clash/views/profiles/profiles.dart';
import 'package:fl_clash/views/crisp_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountView extends ConsumerStatefulWidget {
  const AccountView({super.key});

  @override
  ConsumerState<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends ConsumerState<AccountView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text('退出登录'),
        content: const Text('确定要退出登录吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('退出'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(loginActionProvider.notifier).logout();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isLoggedIn = ref.watch(isLoggedInProvider);

    if (!isLoggedIn) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_outlined,
              size: 64,
              color: colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              '请先登录',
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '我的账户',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          // Refresh button
          IconButton(
            onPressed: () {
              ref.read(currentUserProvider.notifier).fetch();
              ref.read(userSubscriptionProvider.notifier).fetch();
              ref.read(noticesProvider.notifier).fetch();
              ref.read(ordersProvider.notifier).fetch();
              // Crisp doesn't need manual refresh
            },
            icon: const Icon(Icons.refresh),
            tooltip: '刷新',
          ),
          // Logout button
          IconButton(
            onPressed: _handleLogout,
            icon: const Icon(Icons.logout),
            tooltip: '退出登录',
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.person_outline),
              text: '账户',
            ),
            Tab(
              icon: Icon(Icons.notifications_outlined),
              text: '公告',
            ),
            Tab(
              icon: Icon(Icons.chat_outlined),
              text: '客服',
            ),
            Tab(
              icon: Icon(Icons.receipt_long),
              text: '訂單',
            ),
            Tab(
              icon: Icon(Icons.description_outlined),
              text: '配置',
            ),
          ],
          labelColor: colorScheme.primary,
          unselectedLabelColor: colorScheme.onSurfaceVariant,
          indicatorColor: colorScheme.primary,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          UserInfoView(),
          NoticesView(),
          CrispChatView(),
          OrdersView(isEmbedded: true),
          ProfilesView(),
        ],
      ),
    );
  }
}
