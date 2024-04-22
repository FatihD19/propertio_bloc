import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:propertio_mobile/bloc/monitoring/monitoring_bloc.dart';
import 'package:propertio_mobile/shared/theme.dart';
import 'package:propertio_mobile/shared/utils.dart';

import 'package:propertio_mobile/ui/component/search_form.dart';
import 'package:propertio_mobile/ui/component/text_failure.dart';
import 'package:propertio_mobile/ui/widgets/progress_properti.dart';

class MonitoringPropertiPage extends StatelessWidget {
  const MonitoringPropertiPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Daftar Proyek di Indoensia',
              style: primaryTextStyle.copyWith(fontWeight: bold, fontSize: 16)),
          // SizedBox(height: 16),
          // SearchForm(),
          // ExampleWidget()
        ],
      );
    }

    Widget listProgressProyek() {
      return BlocBuilder<MonitoringBloc, MonitoringState>(
        builder: (context, state) {
          if (state is MonitoringLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MonitoringError) {
            return TextFailure(message: state.message);
          }
          if (state is ProjectProgressLoaded) {
            return Column(
                children: state.projectProgress.data!
                    .map((progress) => ProgressProperti(progress))
                    .toList());
          }
          return Container();
        },
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: RefreshIndicator.adaptive(
        onRefresh: () async {
          context.read<MonitoringBloc>().add(OnGetProjectProgress());
        },
        child: ListView(
          children: [
            header(),
            SizedBox(height: 16),
            listProgressProyek(),
          ],
        ),
      ),
    );
  }
}

// class ExampleWidget extends StatefulWidget {
//   @override
//   _ExampleWidgetState createState() => _ExampleWidgetState();
// }

// class _ExampleWidgetState extends State<ExampleWidget> {
//   String _formattedDate = '';

//   @override
//   void initState() {
//     super.initState();
//     _convertDateToString('2023-07-19');
//   }

//   Future<void> _convertDateToString(String dateString) async {
//     String formattedDate = await formatStringToIndonesianDate(dateString);
//     setState(() {
//       _formattedDate = formattedDate;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       _formattedDate,
//       style: TextStyle(fontSize: 18),
//     );
//   }
// }
