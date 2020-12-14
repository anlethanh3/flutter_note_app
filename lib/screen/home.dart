import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_note_app/bloc/home_bloc.dart';
import 'package:flutter_note_app/common/helper.dart';
import 'package:flutter_note_app/common/locale.dart';
import 'package:flutter_note_app/common/routes.dart';
import 'package:flutter_note_app/model/todo.dart';
import 'package:flutter_note_app/model/work.dart';
import 'package:flutter_note_app/repo/home_repository.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final helper = Injector().get<Helper>();
  final locale = Injector().get<Locale>();
  final router = Injector().get<Router>();
  var currentIndex = 0;
  ToDo todo;
  HomeBloc bloc;
  HomeRepository repo;

  @override
  void initState() {
    super.initState();
    repo = HomeRepository(helper);
    bloc = HomeBloc(repo);
    initHomeState();
  }

  void initHomeState() async {
    await Future.delayed(Duration(milliseconds: 300));
    bloc.add(AllEvent());
  }

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
        builder: (context) => RepositoryProvider(
          create: (ctx) => repo,
          child: BlocProvider(
            create: (ctx) => bloc,
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromRGBO(3, 78, 161, 0.95),
                title: Text(locale.appname),
              ),
              bottomNavigationBar: BlocBuilder<HomeBloc, HomeState>(
                builder: (ctx, state) {
                  return BottomNavigationBar(
                    currentIndex: currentIndex,
                    onTap: (index) {
                      currentIndex = index;
                      ctx.bloc<HomeBloc>().add(index == 0
                          ? AllEvent()
                          : (index == 1 ? CompleteEvent() : InCompleteEvent()));
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        title: Text(
                          locale.all,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.done_all),
                        title: Text(
                          locale.complete,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.check),
                        title: Text(
                          locale.incomplete,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                    ],
                  );
                },
              ),
              floatingActionButton:
                  BlocBuilder<HomeBloc, HomeState>(builder: (ctx, state) {
                return FloatingActionButton(
                  heroTag: 'fab',
                  onPressed: () async {
                    final todo = await router.navigateTo(context, Routes.add);
                    if (todo is Work) {
                      ctx.bloc<HomeBloc>().add(AddWorkEvent(todo));
                    }
                  },
                  child: Icon(Icons.add),
                );
              }),
              body: Stack(
                children: <Widget>[
                  BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
                    if (state is InCompleteState) {
                      todo = state.toDo;
                    } else if (state is CompleteState) {
                      todo = state.toDo;
                    } else if (state is AllState) {
                      todo = state.toDo;
                    }
                  }, builder: (ctx, state) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final item = todo.works[index];
                        return Dismissible(
                          key: Key(item.utcTime.toString()),
                          background: Container(
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(locale.delete,
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                          direction: DismissDirection.endToStart,
                          confirmDismiss: (direction) async {
                            bool value = await showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                      title: Text(
                                        locale.confirm,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1,
                                      ),
                                      actions: <Widget>[
                                        CupertinoDialogAction(
                                          child: Text(
                                            locale.yes,
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context, true);
                                          },
                                        ),
                                        CupertinoDialogAction(
                                          child: Text(locale.no,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1),
                                          onPressed: () {
                                            Navigator.pop(context, false);
                                          },
                                          isDefaultAction: true,
                                        ),
                                      ],
                                    ));
                            return value;
                          },
                          onDismissed: (direction) {
                            bloc.add(DeleteWorkEvent(item));
                          },
                          child: CheckboxListTile(
                            value: item.isDone,
                            onChanged: (value) {
                              ctx.bloc<HomeBloc>().add(UpdateWorkEvent(Work(
                                  isDone: value,
                                  utcTime: item.utcTime,
                                  name: item.name,
                                  id: item.id)));
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              item.name,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        );
                      },
                      itemCount: todo?.works?.length ?? 0,
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
