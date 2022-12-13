import 'package:carogame/viewmodel/play_progress_bloc.dart';
import 'package:carogame/viewmodel/play_progress_event.dart';
import 'package:carogame/viewmodel/play_progress_state.dart';
import 'package:carogame/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../style/palette.dart';
import 'responsive_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  const LevelSelectionScreen({super.key});

  static const routerName = "/level-selection-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.backgroundLevelSelection,
      body: ResponsiveScreen(
        squarishMainArea: Column(
          children: [
            const Center(
              child: Text(
                'Select level',
                style: TextStyle(fontFamily: 'Permanent Marker', fontSize: 30),
              ),
            ),
            const SizedBox(height: 50),
            // This is the grid of numbers.
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Column(
                    children: [
                      for (var y = 0; y < 3; y++)
                        Expanded(
                          child: Row(
                            children: [
                              for (var x = 0; x < 3; x++)
                                AspectRatio(
                                  aspectRatio: 1,
                                  child: _LevelButton(y * 3 + x + 1),
                                )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        rectangularMenuArea: ButtonWidget(
          fontSize: 22,
          widget: const Text("Back"),
          onTap: () {
            Navigator.pop(context);
          },
          textColor: Palette.ink,
          buttonRectangle: false,
        ),
      ),
    );
  }
}

class _LevelButton extends StatefulWidget {
  final int number;

  const _LevelButton(this.number, {Key? key}) : super(key: key);

  @override
  State<_LevelButton> createState() => _LevelButtonState();
}

class _LevelButtonState extends State<_LevelButton> {
  @override
  void initState() {
    super.initState();
    final event = ResetLevelPlayProgressEvent();
    context.read<PlayProgressBloc>().add(event);
  }

  @override
  Widget build(BuildContext context) {
    // final playerProgress = context.watch<PlayerProgress>();

    // / Level is either one that the player has already bested, on one above.
    // final available = playerProgress.highestLevelReached + 1 >= number;

    /// We allow the player to skip one level.
    // final availableWithSkip = playerProgress.highestLevelReached + 2 >= number;

    return BlocBuilder<PlayProgressBloc, PlayProgressState>(
        builder: (context, state) {
      final available = state.levelHighestReached + 1 >= widget.number;
      final availableWithSkip = state.levelHighestReached + 2 >= widget.number;
      return ButtonWidget(
          fontSize: 12,
          buttonRectangle: false,
          widget: Image.asset(
            'assets/images/${widget.number}.png',
            semanticLabel: 'Level ${widget.number}',
            fit: BoxFit.cover,
            color: available
                ? Palette.redPen
                : availableWithSkip
                    ? Color.alphaBlend(
                        Palette.redPen.withOpacity(0.6), Palette.ink)
                    : Palette.ink,
          ));
    });
    // DelayedAppear(
    //   ms: ScreenDelays.second + (number - 1) * 70,
    //   child: RoughButton(
    //       onTap: availableWithSkip
    //           ? () => GoRouter.of(context).go('/play/session/$number')
    //           : null,
    //       soundEffect: SfxType.erase,
    //       child: SizedBox.expand(
    //         child: Padding(
    //           padding: const EdgeInsets.all(8),
    //           child: Image.asset(
    //             'assets/images/$number.png',
    //             semanticLabel: 'Level $number',
    //             fit: BoxFit.cover,
    //             color: available
    //                 ? Palette.redPen
    //                 : availableWithSkip
    //                     ? Color.alphaBlend(
    //                         Palette.redPen.withOpacity(0.6), Palette.ink)
    //                     : Palette.ink,
    //           ),
    //         ),
    //       )),
    // );
  }
}
