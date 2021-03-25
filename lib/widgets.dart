import 'package:flutter/material.dart';
import 'package:lorem_ipsum/assets.dart';

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
