import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StartButton extends ConsumerStatefulWidget {
  const StartButton({super.key});

  @override
  ConsumerState<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends ConsumerState<StartButton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  late Animation<double> _animation;
  bool isStart = false;

  @override
  void initState() {
    super.initState();
    isStart = globalState.appState.runTime != null;
    _controller = AnimationController(
      vsync: this,
      value: isStart ? 1 : 0,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeOutBack,
    );
    ref.listenManual(runTimeProvider.select((state) => state != null), (
      prev,
      next,
    ) {
      if (next != isStart) {
        isStart = next;
        updateController();
      }
    }, fireImmediately: true);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _controller = null;
    super.dispose();
  }

  void handleSwitchStart() {
    isStart = !isStart;
    updateController();
    debouncer.call(FunctionTag.updateStatus, () {
      globalState.appController.updateStatus(isStart);
    }, duration: commonDuration);
  }

  void updateController() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isStart && mounted) {
        _controller?.forward();
      } else {
        _controller?.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(startButtonSelectorStateProvider);
    if (!state.isInit || !state.hasProfile) {
      return Container();
    }
    return Consumer(
      builder: (_, ref, _) {
        final runTime = ref.watch(runTimeProvider);
        final isRunning = runTime != null;
        final timeText = utils.getTimeText(runTime);
        
        return SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: handleSwitchStart,
            style: ElevatedButton.styleFrom(
              backgroundColor: isRunning 
                  ? context.colorScheme.errorContainer
                  : context.colorScheme.primaryContainer,
              foregroundColor: isRunning
                  ? context.colorScheme.onErrorContainer
                  : context.colorScheme.onPrimaryContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isRunning ? Icons.stop_rounded : Icons.play_arrow_rounded,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  isRunning ? '斷開連接  $timeText' : '開始連接',
                  style: context.textTheme.titleMedium?.toSoftBold,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
