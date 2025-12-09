import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/models/profile.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilesView extends ConsumerStatefulWidget {
  const ProfilesView({super.key});

  @override
  ConsumerState<ProfilesView> createState() => _ProfilesViewState();
}

class _ProfilesViewState extends ConsumerState<ProfilesView> {
  bool _isDownloading = false;

  /// Mask subscription URL to only show token for privacy
  /// Example: "https://domain.com/api/v1/client/subscribe?token=abc123"
  /// Returns: "Token: abc123..."
  String _maskSubscriptionUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final token = uri.queryParameters['token'];
      if (token != null && token.isNotEmpty) {
        // Show first 8 and last 4 characters of token
        if (token.length > 12) {
          return 'Token: ${token.substring(0, 8)}...${token.substring(token.length - 4)}';
        }
        return 'Token: $token';
      }
      // If no token found, just show "已配置" (configured)
      return '已配置';
    } catch (e) {
      return '已配置';
    }
  }

  Future<void> _forceDownloadProfile(Profile profile) async {
    if (_isDownloading) return;
    
    setState(() {
      _isDownloading = true;
    });
    
    try {
      print('[ProfilesView] Force downloading profile: ${profile.label}');
      
      // Delete existing file to force re-download
      final profilePath = await appPath.getProfilePath(profile.id);
      final file = File(profilePath);
      if (await file.exists()) {
        print('[ProfilesView] Deleting existing file: $profilePath');
        await file.delete();
      }
      
      // Download fresh content
      print('[ProfilesView] Downloading from: ${profile.url}');
      final downloadedProfile = await profile.update();
      
      // Update profile in provider
      ref.read(profilesProvider.notifier).setProfile(downloadedProfile);
      ref.read(currentProfileIdProvider.notifier).update(downloadedProfile.id);
      
      // Apply the profile
      await globalState.appController.applyProfile();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('訂閱更新成功！')),
        );
      }
      print('[ProfilesView] Profile download and apply complete');
    } catch (e) {
      print('[ProfilesView] Error downloading profile: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('下載失敗: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profiles = ref.watch(profilesProvider);
    final currentId = ref.watch(currentProfileIdProvider);

    if (profiles.isEmpty) {
      return const Center(
        child: Text('No profiles. Login to auto-import.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: profiles.length,
      itemBuilder: (context, index) {
        final profile = profiles[index];
        final isSelected = profile.id == currentId;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: CommonCard(
            isSelected: isSelected,
            onPressed: () {
              ref.read(currentProfileIdProvider.notifier).update(profile.id);
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          profile.label ?? 'Unknown Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Theme.of(context).colorScheme.primary : null,
                          ),
                        ),
                      ),
                      // Download/Update button
                      IconButton(
                        onPressed: _isDownloading ? null : () => _forceDownloadProfile(profile),
                        icon: _isDownloading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(Icons.refresh),
                        tooltip: '更新訂閱',
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _maskSubscriptionUrl(profile.url),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
