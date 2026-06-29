import 'package:flutter/material.dart';

class SosDurationSelector extends StatelessWidget {
  const SosDurationSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final durations = [15,30,45,60];

    return Wrap(
      spacing: 10,
      children: durations.map((e){

        final selectedChip = selected==e;

        return ChoiceChip(
          label: Text(
            e==60
                ? "1 Hour"
                : "$e min",
          ),
          selected: selectedChip,
          onSelected: (_){
            onChanged(e);
          },
        );

      }).toList(),
    );
  }
}