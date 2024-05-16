import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc_file/listkata_cubit.dart';
import '../koneksi.dart';

class TabList extends StatelessWidget {
  const TabList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KamusCubit, KamusState>(
      builder: (context, state) {
        if (state == KamusState.loading) {
          return CircularProgressIndicator();
        } else if (state == KamusState.loaded) {
          List<ListKata> data = context.read<KamusCubit>().sortedData;
          return SingleChildScrollView(
            child: DataTable(
              columns: [
                DataColumn(label: Text('Kata')),
                DataColumn(label: Text('Arti')),
              ],
              rows: data
                  .map(
                    (item) => DataRow(
                      cells: [
                        DataCell(Text(item.kata)),
                        DataCell(Text(item.arti)),
                      ],
                    ),
                  )
                  .toList(),
            ),
          );
        } else if (state == KamusState.error) {
          return Text('Error fetching data');
        } else {
          return Text('Unknown state');
        }
      },
    );
  }
}
