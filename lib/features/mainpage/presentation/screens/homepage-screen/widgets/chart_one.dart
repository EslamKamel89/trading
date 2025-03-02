import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:trading/core/text_styles/text_style.dart';
import 'package:trading/core/themes/clr.dart';

class CustomChartOne extends StatefulWidget {
  const CustomChartOne({super.key, required this.sectionColor, required this.value, required this.profitDollar});
  final Color sectionColor;
  final double value;
  final double profitDollar;
  @override
  State<CustomChartOne> createState() => _CustomChartOneState();
}

class _CustomChartOneState extends State<CustomChartOne> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
              showLabels: false,
              showTicks: true,
              startAngle: 0,
              endAngle: 360,
              radiusFactor: 0.9,
              axisLineStyle: AxisLineStyle(
                thickness: 0.1,
                color: widget.sectionColor,
                thicknessUnit: GaugeSizeUnit.factor,
              ),
              pointers: <GaugePointer>[
                RangePointer(
                  value: widget.value,
                  width: 0.05,
                  color: Clr.d,
                  sizeUnit: GaugeSizeUnit.factor,
                  enableAnimation: true,
                  animationDuration: 20,
                  // animationType: AnimationType.ease,
                )
              ],
              annotations: <GaugeAnnotation>[
                GaugeAnnotation(widget: Txt.bodyMeduim('Daily Profit \$${widget.profitDollar.toStringAsFixed(0)}'))
              ])
        ],
      ),
    );
  }
}
