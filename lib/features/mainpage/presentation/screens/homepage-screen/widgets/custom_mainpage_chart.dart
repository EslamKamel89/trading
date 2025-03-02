import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:trading/core/themes/clr.dart';
import 'package:trading/features/mainpage/presentation/screens/homepage-screen/model/chart_data_model.dart';
import 'package:trading/features/onboarding-pick-language/peresentation/blocs/cubit/pick_language_cubit.dart';

class CustomMainpageChart extends StatefulWidget {
  const CustomMainpageChart({
    super.key,
    required this.sectionColor,
    required this.dailyProfitPercent,
    required this.referallProfitPercent,
    required this.profitDollar,
  });
  final Color sectionColor;
  final double dailyProfitPercent;
  final double referallProfitPercent;
  final double profitDollar;
  @override
  State<CustomMainpageChart> createState() => _CustomMainpageChartState();
}

class _CustomMainpageChartState extends State<CustomMainpageChart> {
  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<PickLanguageAndThemeCubit>();
    // "I am here".prm('CustomChartTwo');
    return Center(
        child: SfCircularChart(
      backgroundColor: Colors.transparent,
      key: GlobalKey(),
      // legend: Legend(
      //     toggleSeriesVisibility: false,
      //     isVisible: false,
      //     iconHeight: 20,
      //     iconWidth: 20,
      //     overflowMode: LegendItemOverflowMode.wrap),
      // title: const ChartTitle(text: 'Monthly steps count tracker'),
      // annotations: const <CircularChartAnnotation>[
      //   CircularChartAnnotation(
      //     height: '45%',
      //     width: '65%',
      //     widget: Column(
      //       children: <Widget>[
      //         Padding(
      //             padding: EdgeInsets.only(top: 15),
      //             child: Text('Goal -', style: TextStyle(fontWeight: FontWeight.bold))),
      //         Padding(padding: EdgeInsets.only(top: 10)),
      //         Text('6k steps/day', softWrap: false, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))
      //       ],
      //     ),
      //   ),
      // ],
      series: <RadialBarSeries<ChartData, String>>[
        RadialBarSeries<ChartData, String>(
          maximumValue: 0.25,
          radius: '100%',
          gap: '3%',
          dataSource: [
            ChartData('Referals', widget.referallProfitPercent, Clr.a, 'Referals'),
            ChartData('Daily Profit', widget.dailyProfitPercent, Clr.f, 'Daily Profit'),
          ],
          // cornerStyle: CornerStyle.bothCurve,
          xValueMapper: (ChartData data, _) => data.x,
          yValueMapper: (ChartData data, _) => data.y,
          pointColorMapper: (ChartData data, _) => data.color,
          dataLabelMapper: (ChartData data, _) => data.text,
          trackColor: Colors.transparent,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            // color: Colors.transparent,
            textStyle: TextStyle(
              color: themeController.isLightTheme() ? Colors.black : Colors.white,
            ),
          ),
        )
      ],
      // tooltipBehavior: _tooltipBehavior,
      // onTooltipRender: (TooltipArgs args) {
      //   final NumberFormat numberFormat = NumberFormat.compactCurrency(
      //     decimalDigits: 2,
      //     symbol: '',
      //   );
      //   // ignore: cast_nullable_to_non_nullable
      //   args.text = chartData![args.pointIndex as int].text +
      //       ' : ' +
      //       numberFormat
      //           // ignore: cast_nullable_to_non_nullable
      //           .format(chartData![args.pointIndex as int].y);
      // }
    ));
  }
}
