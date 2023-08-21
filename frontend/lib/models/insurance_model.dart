import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_web3/ethers.dart';

Insurance comingFromContract(List<dynamic> list) => Insurance.from(list);

class Insurance {
  final String owner;
  final String id;
  final String insuranceName;
  final String keyId;
  final double amount;
  final String beneficiary;
  final bool isApproved;
  final double amountForBeneficiary;

  Insurance({
    Key? key,
    required this.owner,
    required this.id,
    required this.insuranceName,
    required this.amountForBeneficiary,
    required this.isApproved,
    required this.keyId,
    required this.amount,
    required this.beneficiary,
  });

  factory Insurance.from(dynamic stu) {
    //print("In the Insurance model");
    return Insurance(
        owner: stu[0].toString(),
        id: stu[1].toString(),
        keyId: stu[2].toString(),
        insuranceName: stu[3].toString(),
        amountForBeneficiary:
            double.parse(EthUtils.formatEther(stu[7].toString())),
        isApproved: stu[8],
        amount: double.parse(EthUtils.formatEther(stu[4].toString())),
        beneficiary: stu[6].toString());
  }

  ethersSplitter(int num) {
    double result = num.toDouble();
    double d = result * 0.000000000000000001;
    return d;
  }
}
