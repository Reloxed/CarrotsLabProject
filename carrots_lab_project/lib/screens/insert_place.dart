import 'package:carrots_lab_project/database/inserts.dart';
import 'package:carrots_lab_project/models/navigation_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InsertPlace extends StatefulWidget {
  @override
  _InsertPlaceState createState() {
    return new _InsertPlaceState();
  }
}

class _InsertPlaceState extends State<InsertPlace> {
  final _formKey = new GlobalKey<FormState>();

  late String name;
  late double latitude;
  late double longitude;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: _addPlaceForm(),
    );
  }

  Widget _addPlaceForm() {
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_nameField(), _latitudeField(), _longitudeField(), _finishButton()],
          ),
        ));
  }

  Widget _nameField() {
    return Container(
        margin: EdgeInsets.only(top: 8.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          validator: (v) {
            if (v!.isEmpty)
              return AppLocalizations.of(context)!.not_empty;
            else
              return null;
          },
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.name),
          onChanged: (value) => this.name = value,
        ));
  }

  Widget _latitudeField() {
    return Container(
        margin: EdgeInsets.only(top: 8.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          validator: (v) {
            if (v!.isEmpty)
              return AppLocalizations.of(context)!.not_empty;
            else if (double.tryParse(v) == null)
              return AppLocalizations.of(context)!.not_coordinate;
            else
              return null;
          },
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.latitude),
          onChanged: (value) => this.latitude = double.tryParse(value)!,
        ));
  }

  Widget _longitudeField() {
    return Container(
        margin: EdgeInsets.only(top: 8.0),
        child: TextFormField(
          textCapitalization: TextCapitalization.words,
          validator: (v) {
            if (v!.isEmpty)
              return AppLocalizations.of(context)!.not_empty;
            else if (double.tryParse(v) == null)
              return AppLocalizations.of(context)!.not_coordinate;
            else
              return null;
          },
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: AppLocalizations.of(context)!.longitude),
          onChanged: (value) => this.longitude = double.tryParse(value)!
        ));
  }

  Widget _finishButton() {
    var provider = Provider.of<NavigationModel>(context);
    return Container(
        margin: EdgeInsets.only(top: 16.0),
        padding: EdgeInsets.symmetric(horizontal: 30.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor, elevation: 3),
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              uploadPlace(name, latitude, longitude);
              provider.changePage(0);
            }
          },
          child: Text(
            AppLocalizations.of(context)!.save,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ));
  }
}
