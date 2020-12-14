import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/common/helper.dart';
import 'package:flutter_note_app/common/locale.dart';
import 'package:flutter_note_app/model/work.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final helper = Injector().get<Helper>();

  final locale = Injector().get<Locale>();

  final router = Injector().get<Router>();

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyText1: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
          subtitle1: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ),
      child: Builder(
        builder: (context) => Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(
              locale.addNote,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(8),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: controller,autofocus: true,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: locale.todoName,
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(color: Colors.black54)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 50,
                      child: FlatButton(
                        onPressed: () {
                          addToDo(context);
                        },
                        color: Colors.orange,
                        child: Text(
                          locale.save,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addToDo(BuildContext context) {
    if (controller.text.trim().isEmpty) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          locale.todoNameRequired,
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(color: Colors.white),
        ),
      ));
    } else {
      Navigator.pop(
          context,
          Work(
              name: controller.text.trim(),
              isDone: false,
              utcTime: DateTime.now().millisecondsSinceEpoch));
    }
  }
}
