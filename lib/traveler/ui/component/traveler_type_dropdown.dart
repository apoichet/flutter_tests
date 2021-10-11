import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';

class TravelerTypeDropdown extends StatefulWidget {
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
  State<TravelerTypeDropdown> createState() => _TravelerTypeDropdownState();
}

class _TravelerTypeDropdownState extends State<TravelerTypeDropdown> {
  late TravelerType valueSelected;

  @override
  void initState() {
    valueSelected = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Semantics(
        button: true,
        label: _getSemanticLabel(),
        child: ExcludeSemantics(
          child: DropdownButton<TravelerType>(
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Theme.of(context).primaryColor),
              itemHeight: null,
              isExpanded: true,
              value: widget.value,
              onChanged: (value) => setState(() {
                    valueSelected = value ?? widget.value;
                    widget.onChanged.call(valueSelected);
                  }),
              items: widget.values
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(
                        value.toShortString(),
                      ),
                    ),
                  )
                  .toList()),
        ),
      ),
    );
  }

  String _getSemanticLabel() =>
      valueSelected.toShortString() +
      " (choice " +
      widget.values.indexOf(valueSelected).toString() +
      " of " +
      widget.values.length.toString() +
      ")";
}
