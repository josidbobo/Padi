import 'dart:convert';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:insurance_dapp/providers/metamask_provider.dart';
import '../models/insurance_model.dart';
import 'package:flutter_web3/flutter_web3.dart';
import '../constants/constants.dart';

class InsuranceProvider extends ChangeNotifier {
  bool loading = false;
  bool error = false;
  bool noErrors = false;
  bool isInsureed = false;
  bool isFinished = false;

  get isLoading => loading;

  String msg = '';

  Contract? anotherContract;
  Contract? contract;

  late Insurance insurance;

  List<Insurance>? portfolioInsuranceList;
  List<Insurance>? insuranceList;

  List<Insurance>? get getInsurance => insuranceList;
  get getPortfolioInsurance => portfolioInsuranceList;

  InsuranceProvider() {
    anotherContract = Contract(insuranceAddress, abii, provider);
    contract = anotherContract!.connect(provider!.getSigner());
    if (MetaMaskProvider.isWC) {
      anotherContract = Contract(insuranceAddress, abii, MetaMaskProvider.web3);
      contract = anotherContract!.connect(MetaMaskProvider.web3!.getSigner());
    }
  }

  static String compressAddress(String address) {
    String c = address.substring(0, 5);
    String d = address.substring(38);

    String result = '$c...$d';

    return result;
  }

  String compressNumber(double num) {
    String num0 = num.toString();
    String c = num0.substring(0, 4);
    return c;
  }

  isInsured() async {
    final txResult = await anotherContract!
        .call<bool>('isInsuree', [MetaMaskProvider.curentAddress]);
    isInsureed = txResult;
    notifyListeners();
  }

  Future<void> insure(String name, String aamount, String beneficiary,
      String amountForBenef, String password) async {
    try {
      loading = true;
      notifyListeners();
      final aamnt = num.parse(
          int.parse(EthUtils.parseEther(aamount).toString()).toString());
      final aamnt2 = num.parse(
          int.parse(EthUtils.parseEther(amountForBenef).toString()).toString());
      Type type = aamnt.runtimeType;

      final insuring = await contract!.send(
          'insure',
          [
            BigInt.from(aamnt),
            name,
            beneficiary,
            BigInt.from(aamnt2),
            password
          ],
          TransactionOverride(value: BigInt.from(aamnt)));

      //print('This is struct\'s first index ${struct[0]}');

      //final dartconv = convertToDart(struct as JsObject);
      //print("The dart conversion is :: $dartconv");
      // insurance = comingFromContract(struct);
      // print("Insurance ID is ${insurance.id}");
      // insuranceList?.add(insurance);
      // notifyListeners();
      // Insurance _item = Insurance(struct);
      // print('This is item $_item');
      // tempInsuranceList.add({
      //   'id': struct[1].toString(),
      //   'ownerAddress': compressAddress(struct[0].toString()),
      //   'insuranceName': struct[2].toString(),
      //   'amount': ethersSplitter(int.parse(struct[3].toString())),
      //   'beneficiary': compressAddress(struct[5].toString()),
      //   'beneficiaryAmount': ethersSplitter(int.parse(struct[6].toString())),
      //   'isApproved': struct[7]
      // });

      // final count = await anotherContract!.call<BigInt>(
      //   'count',
      // );
      // print(count);

      await getInsurances();
      notifyListeners();

      loading = false;
      noErrors = true;
      msg = 'Successful';
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      print(e.toString());
      throw e;
    }
    isFinished = true;
    loading = false;
    notifyListeners();
  }

  ethersSplitter(int num) {
    double result = num.toDouble();
    double d = result * 0.000000000000000001;
    return d;
  }

  Future getInsurances() async {
    try {
      final result = await anotherContract!.call<BigInt>(
          'portfolioCountOfEachUser', [MetaMaskProvider.curentAddress]);
      //print('This is $result');

      final args = [
        for (int i = result.toInt(); i >= 1; i--)
          [MetaMaskProvider.curentAddress, i]
      ];

      final struct = await anotherContract!.multicall('userInsurances', args);
      insuranceList = struct.map((e) => comingFromContract(e)).toList();

      notifyListeners();
      //print('This is insurance struct $struct');

      final count = await anotherContract!.call<BigInt>(
        'count',
      );
      //print('This is count $count');

      final args2 = [
        for (int i = count.toInt(); i >= 1; i--) [i]
      ];
      final struct2 = await anotherContract!.multicall('portfolios', args2);
      //print('This is portfolio struct $struct2');
      portfolioInsuranceList =
          struct2.map((e) => comingFromContract(e)).toList();
      notifyListeners();

      //print('This is portfolio length: ${portfolioInsuranceList!.length}');
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future authorise(String pass, int id) async {
    loading = true;
    notifyListeners();
    final idd = BigInt.from(num.parse(id.toString()));
    try {
      await contract!.call('toggleAuthorisation', [pass, idd]);
      await getInsurances();
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  Future makeClaim(String id, int index, String amount) async {
    loading = true;
    notifyListeners();
    final identity = BigInt.from(num.parse(id));
    final _amount =
        num.parse(int.parse(EthUtils.parseEther(amount).toString()).toString());
    print(_amount);
    print(identity);
    try {
      final result = await contract!.call('makeClaim', [
        identity,
        portfolioInsuranceList![index - 1].beneficiary,
        BigInt.from(_amount)
      ]);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  Future changeBeneficiary(String benef, String pass, int id) async {
    loading = true;
    notifyListeners();
    final identity = BigInt.from(num.parse(id.toString()));
    print(identity);
    try {
      final result =
          await contract!.call('changeBeneficiary', [identity, benef, pass]);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      throw e.toString();
    }
  }

  Future topUp(int id, String amount) async {
    loading = true;
    notifyListeners();
    final aamnt = num.parse(EthUtils.parseEther(amount).toString());
    final idd = BigInt.from(num.parse(id.toString()));
    try {
      await contract!.send(
          'topUpPortfolio',
          [
            idd,
            BigInt.from(aamnt),
          ],
          TransactionOverride(value: BigInt.from(aamnt)));
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      throw e;
    }
  }

  Future changeBeneficiaryAmount(String amount, String pass, int id) async {
    loading = true;
    notifyListeners();
    final identity = BigInt.from(num.parse(id.toString()));
    final amout = BigInt.from(num.parse(EthUtils.parseEther(amount).toString()));
    print(identity);
    try {
       await contract!
          .call('changeBeneficiaryAmount', [identity, amout, pass]);
      loading = false;
      notifyListeners();
    } catch (e) {
      loading = false;
      notifyListeners();
      throw e.toString();
    }
  }
}
