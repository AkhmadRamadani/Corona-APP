import 'package:Corner/Components/littlecard.dart';
import 'package:Corner/Utils/CovidProvinceModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProvinceCard extends StatelessWidget {
  final Province province;
  const ProvinceCard({Key? key, required this.province}) : super(key: key);

  String currencer(data) {
    var currencer = NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
    ).format(data);
    return currencer;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 24),
        Text(
          province.key,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: "Open Sans",
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LittleCard(
                label: 'Kasus',
                jumlah: currencer(province.jumlahKasus),
                lebih: province.penambahan.positif.toString(),
                type: ''),
            LittleCard(
                label: 'Sembuh',
                jumlah: currencer(province.jumlahSembuh),
                lebih: province.penambahan.sembuh.toString(),
                type: 'Recovered'),
            LittleCard(
                label: 'Meninggal',
                jumlah: currencer(province.jumlahMeninggal),
                lebih: province.penambahan.meninggal.toString(),
                type: 'Death'),
          ],
        ),
      ],
    );
  }
}
