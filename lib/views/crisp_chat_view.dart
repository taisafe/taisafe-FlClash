// Crisp Chat View - Customer Support
// Landing page with button to open chat

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CrispChatView extends StatelessWidget {
  const CrispChatView({super.key});

  void _openCrispChat(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const _CrispChatPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Chat icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 48,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 24),
            
            // Title
            Text(
              '線上客服',
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            
            // Description
            Text(
              '如有任何問題，歡迎與我們的客服團隊即時對話。\n我們會盡快回覆您！',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            
            // Open chat button
            FilledButton.icon(
              onPressed: () => _openCrispChat(context),
              icon: const Icon(Icons.chat),
              label: const Text('聯絡客服'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(200, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Service hours info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '服務時間',
                        style: textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '週一至週日 09:00 - 22:00\n(台灣時間 GMT+8)',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Separate page for Crisp chat with close button
class _CrispChatPage extends StatefulWidget {
  const _CrispChatPage();

  @override
  State<_CrispChatPage> createState() => _CrispChatPageState();
}

class _CrispChatPageState extends State<_CrispChatPage> {
  static const String crispWebsiteId = 'f30d0e26-f8d8-4e59-8b98-1447d9547bf7';
  
  bool _isLoading = true;

  Uri get crispEmbedUrl => Uri.parse(
    'https://go.crisp.chat/chat/embed/?website_id=$crispWebsiteId'
  );

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: '關閉對話',
        ),
        title: const Text('線上客服'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
              });
            },
            tooltip: '重新載入',
          ),
        ],
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri.uri(crispEmbedUrl)),
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              domStorageEnabled: true,
              databaseEnabled: true,
              cacheEnabled: true,
              supportZoom: false,
              transparentBackground: false,
              mediaPlaybackRequiresUserGesture: false,
              allowsInlineMediaPlayback: true,
              mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
              useWideViewPort: true,
              loadWithOverviewMode: true,
              userAgent: 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
            ),
            onLoadStart: (controller, url) {
              if (mounted) {
                setState(() {
                  _isLoading = true;
                });
              }
            },
            onLoadStop: (controller, url) async {
              if (mounted) {
                setState(() {
                  _isLoading = false;
                });
              }
            },
          ),
          
          // Loading overlay
          if (_isLoading)
            Container(
              color: colorScheme.surface,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '正在載入客服系統...',
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
