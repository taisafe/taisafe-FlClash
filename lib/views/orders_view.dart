import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/v2board_models.dart';
import 'package:fl_clash/providers/v2board_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersView extends ConsumerStatefulWidget {
  final bool isEmbedded;
  
  const OrdersView({
    super.key,
    this.isEmbedded = false,
  });

  @override
  ConsumerState<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends ConsumerState<OrdersView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(ordersProvider.notifier).fetch();
    });
  }

  Future<void> _cancelOrder(String tradeNo) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('取消訂單'),
        content: const Text('確定要取消此訂單嗎？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('確定'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final success = await ref.read(orderActionProvider.notifier).cancel(tradeNo);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('訂單已取消'), backgroundColor: Colors.green),
      );
    }
  }

  Future<void> _payOrder(String tradeNo, int amount) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('支付訂單'),
        content: Text('確認支付 $amount 點？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('確認支付'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final success = await ref.read(orderActionProvider.notifier).checkout(tradeNo);
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('支付成功'), backgroundColor: Colors.green),
      );
    } else if (mounted) {
      final error = ref.read(orderActionProvider).error;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('支付失敗: $error'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEmbedded) {
      return _buildBody();
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的訂單'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(ordersProvider.notifier).fetch(),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }
  
  Widget _buildBody() {
    final ordersAsync = ref.watch(ordersProvider);
    final colorScheme = Theme.of(context).colorScheme;
    
    return RefreshIndicator(
      onRefresh: () => ref.read(ordersProvider.notifier).fetch(),
      child: ordersAsync.when(
        data: (orders) {
          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                     Icons.receipt_long_outlined, 
                     size: 64, 
                     color: colorScheme.onSurfaceVariant.withOpacity(0.5)
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '暫無訂單',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final order = orders[index];
              return _buildOrderCard(order, colorScheme);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.grey),
              const SizedBox(height: 8),
              Text('載入失敗: $error'),
              TextButton(
                onPressed: () => ref.read(ordersProvider.notifier).fetch(),
                child: const Text('重試'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderCard(V2BoardOrder order, ColorScheme colorScheme) {
    final createdDate = order.createdAt != null
        ? DateTime.fromMillisecondsSinceEpoch(order.createdAt! * 1000)
        : null;

    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '訂單號: ${order.tradeNo}',
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: order.statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.statusText,
                    style: TextStyle(
                      color: order.statusColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.plan?.name ?? '套餐 #${order.planId}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (order.cycle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          '週期: ${order.cycle}', // Ideally map this using V2BoardPlanExtension but we don't have plan object always
                          style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Text(
                  '${order.totalAmount ?? 0} 點',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            if (createdDate != null) ...[
              const SizedBox(height: 8),
              Text(
                '創建時間: ${createdDate.toString().split('.')[0]}',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            if (order.status == 0) ...[ // Pending status
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                   OutlinedButton(
                    onPressed: () => _cancelOrder(order.tradeNo!),
                    child: const Text('取消訂單'),
                  ),
                  const SizedBox(width: 12),
                  FilledButton(
                    onPressed: () => _payOrder(order.tradeNo!, order.totalAmount ?? 0),
                    style: FilledButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                    ),
                    child: const Text('立即支付'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
