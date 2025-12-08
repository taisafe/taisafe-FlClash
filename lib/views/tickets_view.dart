// Tickets View - iOS 26 Clean Style
// Displays user support tickets and allows creating new ones

import 'package:fl_clash/models/v2board_models.dart';
import 'package:fl_clash/providers/v2board_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TicketsView extends ConsumerWidget {
  const TicketsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsAsync = ref.watch(ticketsProvider);
    
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(ticketsProvider.notifier).fetch();
        },
        child: ticketsAsync.when(
          data: (tickets) => tickets.isEmpty
            ? _buildEmptyState(context)
            : _buildTicketsList(context, ref, tickets),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => _buildErrorState(context, e.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateTicketDialog(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('新建工单'),
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
            Icons.support_agent_outlined,
            size: 64,
            color: colorScheme.onSurfaceVariant.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            '暂无工单',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '如有问题，请点击下方按钮创建工单',
            style: TextStyle(
              color: colorScheme.onSurfaceVariant.withOpacity(0.7),
              fontSize: 14,
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
          Icon(Icons.error_outline, size: 64, color: colorScheme.error),
          const SizedBox(height: 16),
          Text(error, style: TextStyle(color: colorScheme.error)),
        ],
      ),
    );
  }
  
  Widget _buildTicketsList(
    BuildContext context, 
    WidgetRef ref, 
    List<V2BoardTicket> tickets,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: tickets.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return _TicketCard(
          ticket: ticket,
          onTap: () => _showTicketDetail(context, ref, ticket),
        );
      },
    );
  }
  
  void _showCreateTicketDialog(BuildContext context, WidgetRef ref) {
    final subjectController = TextEditingController();
    final messageController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '新建工单',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: subjectController,
                  decoration: InputDecoration(
                    labelText: '主题',
                    hintText: '请简要描述问题',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (v) => v?.isEmpty == true ? '请输入主题' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    labelText: '详细描述',
                    hintText: '请详细描述您的问题',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (v) => v?.isEmpty == true ? '请输入问题描述' : null,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await ref.read(ticketsProvider.notifier).createTicket(
                            subject: subjectController.text.trim(),
                            message: messageController.text.trim(),
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('工单已提交')),
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('提交失败：$e')),
                            );
                          }
                        }
                      }
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('提交工单'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _showTicketDetail(
    BuildContext context, 
    WidgetRef ref, 
    V2BoardTicket ticket,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => _TicketDetailPage(ticket: ticket),
      ),
    );
  }
}

class _TicketCard extends StatelessWidget {
  final V2BoardTicket ticket;
  final VoidCallback onTap;
  
  const _TicketCard({
    required this.ticket,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _getStatusColor(colorScheme).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _getStatusIcon(),
                size: 20,
                color: _getStatusColor(colorScheme),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ticket.subject ?? '工单 #${ticket.id}',
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(colorScheme).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          ticket.statusText,
                          style: textTheme.labelSmall?.copyWith(
                            color: _getStatusColor(colorScheme),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (ticket.createdDate != null)
                        Text(
                          DateFormat('MM-dd HH:mm').format(ticket.createdDate!),
                          style: textTheme.labelSmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
  
  Color _getStatusColor(ColorScheme colorScheme) {
    switch (ticket.status) {
      case TicketStatus.pending:
        return colorScheme.tertiary;
      case TicketStatus.processing:
        return colorScheme.primary;
      case TicketStatus.replied:
        return colorScheme.secondary;
      case TicketStatus.closed:
        return colorScheme.onSurfaceVariant;
    }
  }
  
  IconData _getStatusIcon() {
    switch (ticket.status) {
      case TicketStatus.pending:
        return Icons.schedule;
      case TicketStatus.processing:
        return Icons.sync;
      case TicketStatus.replied:
        return Icons.mark_chat_read;
      case TicketStatus.closed:
        return Icons.check_circle_outline;
    }
  }
}

class _TicketDetailPage extends ConsumerStatefulWidget {
  final V2BoardTicket ticket;
  
  const _TicketDetailPage({required this.ticket});

  @override
  ConsumerState<_TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends ConsumerState<_TicketDetailPage> {
  final _replyController = TextEditingController();
  bool _isSending = false;

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final ticket = widget.ticket;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('工单 #${ticket.id}'),
        actions: [
          if (ticket.status != TicketStatus.closed)
            TextButton(
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('关闭工单'),
                    content: const Text('确定要关闭此工单吗？'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx, false),
                        child: const Text('取消'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('确定'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await ref.read(ticketsProvider.notifier).closeTicket(ticket.id);
                  if (context.mounted) Navigator.pop(context);
                }
              },
              child: const Text('关闭'),
            ),
        ],
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ticket.subject ?? '',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      ticket.statusText,
                      style: textTheme.labelMedium?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (ticket.createdDate != null)
                      Text(
                        '创建于 ${DateFormat('yyyy-MM-dd HH:mm').format(ticket.createdDate!)}',
                        style: textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          
          // Messages
          Expanded(
            child: ticket.message?.isEmpty ?? true
              ? Center(
                  child: Text(
                    '暂无消息',
                    style: TextStyle(color: colorScheme.onSurfaceVariant),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: ticket.message!.length,
                  itemBuilder: (context, index) {
                    final msg = ticket.message![index];
                    return _MessageBubble(message: msg);
                  },
                ),
          ),
          
          // Reply Input
          if (ticket.status != TicketStatus.closed)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                ),
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _replyController,
                        decoration: InputDecoration(
                          hintText: '输入回复内容...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: colorScheme.surfaceContainerHighest,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                        maxLines: null,
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filled(
                      onPressed: _isSending ? null : _sendReply,
                      icon: _isSending
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Future<void> _sendReply() async {
    final text = _replyController.text.trim();
    if (text.isEmpty) return;
    
    setState(() => _isSending = true);
    
    try {
      await ref.read(ticketsProvider.notifier).replyTicket(
        ticketId: widget.ticket.id,
        message: text,
      );
      _replyController.clear();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('发送失败：$e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }
}

class _MessageBubble extends StatelessWidget {
  final V2BoardTicketMessage message;
  
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isMe = message.isMe ?? false;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: colorScheme.secondaryContainer,
              child: Icon(
                Icons.support_agent,
                size: 16,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe 
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.message ?? '',
                    style: textTheme.bodyMedium?.copyWith(
                      color: isMe 
                        ? colorScheme.onPrimaryContainer
                        : colorScheme.onSurface,
                    ),
                  ),
                  if (message.createdAt != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      DateFormat('HH:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          message.createdAt! * 1000,
                        ),
                      ),
                      style: textTheme.labelSmall?.copyWith(
                        color: (isMe 
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurfaceVariant
                        ).withOpacity(0.7),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (isMe) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
