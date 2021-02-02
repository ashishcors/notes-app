import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notesapp/src/blocs/notes/notes_bloc.dart';
import 'package:notesapp/src/blocs/notes/notes_event.dart';
import 'package:notesapp/src/blocs/notes/notes_state.dart';
import 'package:notesapp/src/models/note.dart';
import 'package:notesapp/src/routing/route_names.dart';
import 'package:notesapp/src/services/navigation_service.dart';
import 'package:notesapp/src/widgets/drawer_layout.dart';

import '../../locator.dart';

class HomePage extends StatelessWidget {
  HomePage() {
    _verifyLogin();
  }

  void _verifyLogin() async {
    // final isLoggedIn = await locator<AuthService>().isUserLoggedIn();
    // if (!isLoggedIn)
    //   locator<NavigationService>().navigateToClearStack(loginRoute);
    // else
    //   _verifyEmail();
  }

  void _verifyEmail() async {
    // final isEmailVerified = await locator<AuthService>().isEmailVerified();
    // if (!isEmailVerified)
    //   locator<NavigationService>().navigateToClearStack(emailVerificationRoute);
  }

  void _fetchUserData(BuildContext context) async {
    // final prefs = locator<PrefsService>();
    // final userId = locator<AuthService>().firebaseUser.uid;
    // locator<DatabaseService>().getUser(userId).then((value) {
    //   prefs.userData = User.fromJson(value.data);
    // }).catchError((_) => {});
  }

  @override
  Widget build(BuildContext context) {
    _fetchUserData(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => locator<NavigationService>().navigateTo(addNoteRoute),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => NotesBloc(locator()),
          child: HomePageLayout(),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          '${true ?? 'Nameless Fellow'}\'s Notes',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => _fetchUserData(context),
            icon: Icon(Icons.refresh),
          )
        ],
      ),
      drawer: Drawer(
        child: DrawerLayout(),
      ),
    );
  }
}

class HomePageLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: NoteList(),
    );
  }
}

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  int _crossAxisCount(BuildContext context) {
    final screenSize = MediaQuery.of(context).size.width;
    if (screenSize > 1000) return 5;
    if (screenSize > 800) return 4;
    if (screenSize > 600) return 3;
    return 2;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<NotesBloc>(context).add(GetNotes());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state is NotesInitial) {
          return Center(child: new Text('Loading...'));
        } else if (state is NotesLoading) {
          return Center(child: new Text('Loading...'));
        } else if (state is NotesLoaded) {
          if (state.noteList.isEmpty)
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.sentiment_dissatisfied,
                    size: 40,
                  ),
                  Text(
                    'Nothing Here',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            );
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _crossAxisCount(context),
            ),
            shrinkWrap: true,
            itemBuilder: (context, i) => NoteView(state.noteList[i]),
            itemCount: state.noteList.length,
          );
        } else if (state is NotesError) {
          return Text('Error: ${state.message}');
        }
        return null;
      },
    );
  }
}

class NoteView extends StatelessWidget {
  final Note _note;

  NoteView(this._note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        locator<NavigationService>().navigateTo(
          editNoteRoute,

          /// Creating a copy because reference of note is passed by default.
          /// And since we'll be modifying this, we want value, not reference.
          argument: Note.copy(_note),
        )
      },
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _note.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              style: TextStyle(fontSize: 20),
            ),
            Text(
              //Todo: Improve this
              _note.message,
              overflow: TextOverflow.fade,
              softWrap: true,
              maxLines: 7,
            ),
          ],
        ),
      ),
    );
  }
}
