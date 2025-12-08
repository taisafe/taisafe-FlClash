// Notices View - iOS 26 Clean Style
// Displays announcements and notifications from V2Board

import 'package:fl_clash/models/v2board_models.dart';
import 'package:fl_clash/providers/v2board_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class NoticesView extends ConsumerWidget {
  const NoticesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticesAsync = ref.watch(noticesProvider);
    
    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(noticesProvider.notifier).fetch();
      },
      child: noticesAsync.when(
        data: (notices) => notices.isEmpty
          ? _buildEmptyState(context)
          : _buildNoticesList(context, notices),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _buildErrorState(context, e.toString()),
      ),
    );
  }
  
  Widget _buildEmptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无公告',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildErrorState(BuildContext context, String error) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            error,
            style: TextStyle(color: colorScheme.error),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNoticesList(BuildContext context, List<V2BoardNotice> notices) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: notices.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final notice = notices[index];
        return _NoticeCard(notice: notice);
      },
    );
  }
}

class _NoticeCard extends StatefulWidget {
  final V2BoardNotice notice;
  
  const _NoticeCard({required this.notice});

  @override
  State<_NoticeCard> createState() => _NoticeCardState();
}

class _NoticeCardState extends State<_NoticeCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final notice = widget.notice;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isExpanded 
            ? colorScheme.primary.withOpacity(0.3)
            : Colors.transparent,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.campaign_outlined,
                      size: 20,
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notice.title ?? '公告',
                          style: textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          maxLines: _isExpanded ? null : 1,
                          overflow: _isExpanded ? null : TextOverflow.ellipsis,
                        ),
                        if (notice.createdDate != null)
                          Text(
                            DateFormat('yyyy-MM-dd HH:mm').format(notice.createdDate!),
                            style: textTheme.labelSmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Icon(
                    _isExpanded 
                      ? Icons.keyboard_arrow_up 
                      : Icons.keyboard_arrow_down,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              
              // Content (expandable)
              AnimatedCrossFade(
                firstChild: const SizedBox.shrink(),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    Divider(
                      height: 1,
                      color: colorScheme.outlineVariant.withOpacity(0.5),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      notice.content ?? '',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                    
                    // Tags
                    if (notice.tags != null && notice.tags!.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: notice.tags!.map((tag) => Chip(
                          label: Text(
                            tag,
                            style: textTheme.labelSmall,
                          ),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        )).toList(),
                      ),
                    ],
                  ],
                ),
                crossFadeState: _isExpanded 
                  ? CrossFadeState.showSecond 
                  : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 200),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
