import 'package:fl_clash/models/profile.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilesView extends ConsumerWidget {
  const ProfilesView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  Text(
                    profile.label ?? 'Unknown Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Theme.of(context).colorScheme.primary : null,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.url,
                    style: Theme.of(context).textTheme.bodySmall,
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
