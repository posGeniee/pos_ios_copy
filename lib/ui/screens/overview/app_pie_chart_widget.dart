import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AppPieChartWidget extends StatefulWidget {
  final List<SalesData> saleData;
  const AppPieChartWidget({
    Key? key,
    required this.saleData,
  }) : super(key: key);

  @override
  _AppPieChartWidgetState createState() => _AppPieChartWidgetState();
}

class _AppPieChartWidgetState extends State<AppPieChartWidget> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SfCircularChart(
        // Enables the legend
        legend: Legend(
          isVisible: true,
          alignment: ChartAlignment.center,
        ),
        tooltipBehavior: _tooltipBehavior,
        series: <CircularSeries<SalesData, String>>[
          // Initialize line series
          PieSeries<SalesData, String>(
            dataSource: widget.saleData,
            xValueMapper: (SalesData sales, _) => sales.departmentName,
            yValueMapper: (SalesData sales, _) => sales.departmentSale,

            dataLabelMapper: (SalesData data, _) =>
                data.departmentSale.toStringAsFixed(2) + '\$',

            name: 'Sales',
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                useSeriesColor: true,
                connectorLineSettings: ConnectorLineSettings(
                    // Type of the connector line
                    type: ConnectorType.curve)
                // overflowMode: OverflowMode.trim

                // labelPosition: ChartDataLabelPosition.inside,
                ),

            // explode: true,
            // // All the segments will be exploded
            // explodeAll: true,
          )
        ],
      ),
    );
  }
}

class SalesData {
  SalesData(this.departmentName, this.departmentSale);

  final String departmentName;
  final double departmentSale;
}
