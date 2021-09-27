import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';

class TravelerTypeDropdown extends StatelessWidget {
  final TravelerType value;
  final List<TravelerType> values;
  final ValueChanged<TravelerType> onChanged;

  TravelerTypeDropdown(
      {Key? key,
      required this.value,
      required this.values,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButtonFormField<TravelerType>(
          style: Theme.of(context)
              .textTheme
              .bodyText2
              ?.copyWith(color: Theme.of(context).accentColor),
          value: value,
          onChanged: (value) => onChanged.call(value!),
          items: values
              .map(
                (value) => DropdownMenuItem(
                  value: value,
                  child: Text(
                    value.toShortString(),
                  ),
                ),
              )
              .toList()),
    );
  }
}
