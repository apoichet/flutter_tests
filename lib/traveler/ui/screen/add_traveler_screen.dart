import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tests/traveler/logic/traveler_description/traveler_description_cubit.dart';
import 'package:flutter_tests/traveler/logic/traveler_description/traveler_description_state.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_bloc.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_event.dart';
import 'package:flutter_tests/traveler/logic/traveler_form_state.dart';
import 'package:flutter_tests/traveler/model/traveler.dart';
import 'package:flutter_tests/traveler/repository/traveler_repository_fake.dart';
import 'package:flutter_tests/traveler/ui/component/custom_input.dart';
import 'package:flutter_tests/traveler/ui/component/traveler_type_dropdown.dart';
import 'package:flutter_tests/traveler/ui/screen/add_traveler_success_screen.dart';

class AddTravelerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TravelerRepositoryFake(),
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (newContext) => TravelerFormBloc(RepositoryProvider.of<TravelerRepositoryFake>(newContext)),
        ),
        BlocProvider(
            create: (newContext) => TravelerDescriptionCubit(
                initialTravelerType: TravelerType.ADULT,
                travelerFormBloc: BlocProvider.of<TravelerFormBloc>(newContext))),
      ], child: AddTraveler()),
    );
  }
}

class AddTraveler extends StatelessWidget {
  const AddTraveler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TravelerFormBloc, TravelerFormState>(
      listener: (context, state) async {
        if (state is AddTravelerSuccess) {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTravelerSuccessScreen(state.traveler)),
          );
        }
        if (state is AddTravelerError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.msgError),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is AddTravelerLoading) {
          return _AddTravelerLoading();
        }
        return _AddTravelerForm(tarvelerInput: state.traveler);
      },
    );
  }
}

class _AddTravelerLoading extends StatelessWidget {
  const _AddTravelerLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _AddTravelerForm extends StatefulWidget {
  final Traveler tarvelerInput;

  const _AddTravelerForm({Key? key, required this.tarvelerInput}) : super(key: key);

  @override
  _AddTravelerFormState createState() => _AddTravelerFormState();
}

class _AddTravelerFormState extends State<_AddTravelerForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _ageController;
  late TravelerType _travelerType;

  @override
  void initState() {
    _reset();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant _AddTravelerForm oldWidget) {
    _reset();
    super.didUpdateWidget(oldWidget);
  }

  _reset() {
    _formKey = GlobalKey();
    _firstnameController = TextEditingController(text: widget.tarvelerInput.firstName);
    _lastnameController = TextEditingController(text: widget.tarvelerInput.lastName);
    _ageController = TextEditingController(text: widget.tarvelerInput.age.toString());
    _travelerType = widget.tarvelerInput.type;
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Traveler'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomInput(
                    key: Key("firstnameInput"),
                    controller: _firstnameController,
                    inputType: TextInputType.text,
                    label: 'Firstname:',
                    validator: (value) => value?.isNotEmpty == true ? null : 'Firstname is mandatory',
                  ),
                  CustomInput(
                    key: Key("lastnameInput"),
                    controller: _lastnameController,
                    inputType: TextInputType.text,
                    label: 'Lastname:',
                    validator: (value) => value?.isNotEmpty == true ? null : 'Lastname is mandatory',
                  ),
                  CustomInput(
                    key: Key("ageInput"),
                    controller: _ageController,
                    inputType: TextInputType.number,
                    label: 'Age:',
                    validator: (value) =>
                        value?.isNotEmpty == true && int.tryParse(value!) != null ? null : 'Age must be a number',
                  ),
                  TravelerTypeDropdown(
                    key: ValueKey("TravelerTypeDropdown"),
                    onChanged: (value) {
                      setState(() {
                        _travelerType = value;
                        BlocProvider.of<TravelerDescriptionCubit>(context).newDescriptionFrom(value);
                      });
                    },
                    value: _travelerType,
                    values: TravelerType.values,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<TravelerDescriptionCubit, TravelerDescriptionState>(
                    builder: (_, state) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(state.description),
                      );
                    },
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((_) => Colors.blue),
                            fixedSize: MaterialStateProperty.resolveWith(
                              (_) => Size(120, 35),
                            )),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            BlocProvider.of<TravelerFormBloc>(context).add(AddTravelerEvent(
                              Traveler(
                                type: _travelerType,
                                age: _ageController.text,
                                lastName: _lastnameController.text,
                                firstName: _firstnameController.text,
                              ),
                            ));
                          }
                        },
                        child: Text('Add'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((_) => Colors.amber),
                            fixedSize: MaterialStateProperty.resolveWith(
                              (_) => Size(120, 35),
                            )),
                        onPressed: () => BlocProvider.of<TravelerFormBloc>(context).add(ClearTravelerEvent(
                          Traveler(
                            type: _travelerType,
                            age: _ageController.text,
                            lastName: _lastnameController.text,
                            firstName: _firstnameController.text,
                          ),
                        )),
                        child: Text('Clear'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
