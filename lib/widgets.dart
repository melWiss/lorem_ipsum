import 'package:flutter/material.dart';
import 'package:lorem_ipsum/assets.dart';

import 'models/user.dart';

/// this widget have the same functionality as StreamBuilder but with less code
class StreamWidget<T> extends StatelessWidget {
  final Stream<T> stream;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context) onWait;
  final Widget Function(BuildContext context, String error) onError;

  StreamWidget({
    @required this.stream,
    @required this.builder,
    this.onError,
    this.onWait,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return builder(context, snapshot.data);
        else if (snapshot.hasError) {
          if (onError != null)
            return onError(context, snapshot.error);
          else
            return Center(
              child: Text(snapshot.error.toString()),
            );
        }
        if (onWait != null) return onWait(context);
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

/// this widget have the same functionality as FutureBuilder but with less code
class FutureWidget<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(BuildContext context, T data) builder;
  final Widget Function(BuildContext context) onWait;
  final Widget Function(BuildContext context, String error) onError;

  FutureWidget({
    @required this.future,
    @required this.builder,
    this.onError,
    this.onWait,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData)
          return builder(context, snapshot.data);
        else if (snapshot.hasError) {
          if (onError != null)
            return onError(context, snapshot.error);
          else
            return Center(
              child: Text(snapshot.error.toString()),
            );
        }
        if (onWait != null) return onWait(context);
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class BannerLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            Text(
              "Q'awini",
              style: Assets.subTitle,
            ),
          ],
        ),
      ),
    );
  }
}

Future qawiniSheet(BuildContext context, Widget child) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: (context) {
      return child;
    },
  );
}

class QawiniLogo extends StatelessWidget {
  const QawiniLogo({
    Key key,
    @required this.mq,
  }) : super(key: key);

  final MediaQueryData mq;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      mq.platformBrightness == Brightness.light
          ? 'assets/logo_dark.png'
          : 'assets/logo_light.png',
      height: mq.size.height * .2,
      width: mq.size.height * .2,
      fit: BoxFit.cover,
    );
  }
}

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  BackgroundWidget({this.child});
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: mq.platformBrightness == Brightness.light
              ? [
                  Colors.white,
                  Colors.white,
                ]
              : [
                  Colors.black,
                  Colors.black87,
                ],
        ),
      ),
      child: child,
    );
  }
}
