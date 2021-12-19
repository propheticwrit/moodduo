import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mood/ui/page/daily/cubit/daily_cubit.dart';

class DailyPage extends StatefulWidget {
  const DailyPage({Key? key}) : super(key: key);

  @override
  State<DailyPage> createState() => _DailyPageState();
}

class _DailyPageState extends State<DailyPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyCubit, DailyState>(
      // bloc: configurationCubit,
      builder: (context, state) {
        if (state is DailyError) {
          return Center(child: Text((state).message));
        }

        return _buildContent(context);
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          children: _columnList(context),
        );
      },
    );
  }

  List<Widget> _columnList(BuildContext context) {
    List<Widget> columnList = <Widget>[];
    columnList.add(Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(DateFormat.yMMMMEEEEd().format(DateTime.now())),
    ));
    return columnList;
  }
}
