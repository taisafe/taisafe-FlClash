import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/views/dashboard/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        spacing: 12,
        children: [
          // Row 1: TrafficUsage + OutboundMode
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: TrafficUsage()),
              const SizedBox(width: 12),
              Expanded(child: OutboundMode()),
            ],
          ),
          // Row 2: NetworkSpeed + Column(NetworkDetection, TUNButton)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: NetworkSpeed()),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: const [
                    NetworkDetection(),
                    SizedBox(height: 12),
                    TUNButton(),
                  ],
                ),
              ),
            ],
          ),
          // SystemProxy + VPN side by side
          Row(
            children: const [
              Expanded(child: SystemProxyButton()),
              SizedBox(width: 12),
              Expanded(child: VpnButton()),
            ],
          ),
          // Start button at the bottom
          StartButton(),
          const SizedBox(height: 8),
          // Tutorial section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📖 使用說明',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '🔀 出站模式',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '• 規則：根據規則自動判斷，國內網站直連、國外網站走代理（推薦）\n'
                  '• 全局：所有流量都走代理\n'
                  '• 直連：所有流量都不走代理',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  '🌐 代理方式',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '• 系統代理：僅代理瀏覽器和支援系統代理的應用（電腦推薦）\n'
                  '• VPN：代理所有應用流量（手機推薦）\n'
                  '• 虛擬網卡：更底層的代理方式，可代理遊戲等特殊應用',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

