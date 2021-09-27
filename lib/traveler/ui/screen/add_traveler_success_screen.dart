import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';

class AddTravelerSuccessScreen extends StatelessWidget {
  final Traveler traveler;

  const AddTravelerSuccessScreen(this.traveler, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Success !'),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'New Traveler',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: 16,
            ),
            _TravelerField(
              field: "First name",
              value: traveler.firstName,
            ),
            SizedBox(
              height: 8,
            ),
            _TravelerField(
              field: "Last name",
              value: traveler.lastName,
            ),
            SizedBox(
              height: 8,
            ),
            _TravelerField(
              field: "Age",
              value: traveler.age,
            ),
            SizedBox(
              height: 8,
            ),
            _TravelerField(
              field: "Type",
              value: traveler.type.toShortString(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TravelerField extends StatelessWidget {
  final String field;
  final String value;

  const _TravelerField({Key? key, required this.field, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          field + ":",
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
