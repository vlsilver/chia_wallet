import 'package:chia_wallet/core/ec.dart';
import 'package:chia_wallet/util/util.dart';
import 'package:chia_wallet/wallet/chia_wallet.dart';
import 'package:chia_wallet/wallet/private_key.dart';
import 'package:chia_wallet/wallet/transaction.dart';

void main() {
  ChiaWallet().init(
      'acid shrimp artist topple interest layer cabin normal veteran prefer acquire radar short candy script whip add ocean pudding glimpse economy cactus clap pear');

  testPrivatekeyAddress();
  testSignMessage();
  testTransaction();
}

void testTransaction() {
  var transaction = ChiaWallet.signTransaction(
      amount: BigInt.from(176000000000),
      from: 'xch15x4c3dq6p7v9p0dswt4atdenvxjlqucrqvm8k4hchtrvnnw6pgvsle55qy',
      to: 'xch1w8re40fykm8k82f2tkx3e2yqzn7nkwwt8scqsa3hp2kyw7snkkvqp3yhed',
      fee: BigInt.zero,
      privateKey: ChiaWallet().getWalletKey("m/12381'/8444'/2'/0"),
      utxos: [
        CoinUnspent(
            parentCoinInfo: Util.toBytes(
                'ccd5bb71183532bff220ba46c268991a000000000000000000000000000e5a2d'),
            puzzleHash: Util.toBytes(
                'a1ab88b41a0f9850bdb072ebd5b73361a5f0730303367b56f8bac6c9cdda0a19'),
            amount: BigInt.from(1750000000000),
            spent: false,
            timestamp: 0),
        CoinUnspent(
            parentCoinInfo: Util.toBytes(
                'ccd5bb71183532bff220ba46c268991a000000000000000000000000000e5a2d'),
            puzzleHash: Util.toBytes(
                'a1ab88b41a0f9850bdb072ebd5b73361a5f0730303367b56f8bac6c9cdda0a19'),
            amount: BigInt.from(1750000000000),
            spent: false,
            timestamp: 0)
      ]);
  print(transaction ==
      '{"spend_bundle":{"aggregated_signature":"0x8dfec1522145b632e54790d5e7d8073a845eca705fcce1e92ba0a55b85a0b1f3922faaaaca8b34be7abd4acf99f05caa00d5bfb3bd27254d6fb3cf3992e4d712e033080819781eb2c4de50b850bec926d4f7020c21052f0c7342abea1d84582f","coin_solutions":[{"coin":{"amount":1750000000000,"parent_coin_info":"0xccd5bb71183532bff220ba46c268991a000000000000000000000000000e5a2d","puzzle_hash":"0xa1ab88b41a0f9850bdb072ebd5b73361a5f0730303367b56f8bac6c9cdda0a19"},"puzzle_reveal":"0xff02ffff01ff02ffff01ff02ffff03ff0bffff01ff02ffff03ffff09ff05ffff1dff0bffff1effff0bff0bffff02ff06ffff04ff02ffff04ff17ff8080808080808080ffff01ff02ff17ff2f80ffff01ff088080ff0180ffff01ff04ffff04ff04ffff04ff05ffff04ffff02ff06ffff04ff02ffff04ff17ff80808080ff80808080ffff02ff17ff2f808080ff0180ffff04ffff01ff32ff02ffff03ffff07ff0580ffff01ff0bffff0102ffff02ff06ffff04ff02ffff04ff09ff80808080ffff02ff06ffff04ff02ffff04ff0dff8080808080ffff01ff0bffff0101ff058080ff0180ff018080ffff04ffff01b0a4cf71ae6c47268c2d61bd48264f0fd92afff82daf7439544708c74ae5252f8162ff5add63bec7988e9599f0da58fb22ff018080","solution":"0xff80ffff01ffff33ffa071c79abd24b6cf63a92a5d8d1ca88014fd3b39cb3c300876370aac477a13b598ff8528fa6ae00080ffff33ffa0a1ab88b41a0f9850bdb072ebd5b73361a5f0730303367b56f8bac6c9cdda0a19ff86016e79b5fc0080ffff3cffa04ad15295693eb390cb5e64810115707e8db8723ef24eae9458811efa9158f6688080ff8080"}]}}');
}

void testSignMessage() {
  final sk1Bytes = List.filled(32, 1);
  final sk2Bytes = List.generate(32, (index) => index * 314159 % 256);
  final sk1 = PrivateKey.fromBytes(sk1Bytes);
  final sk2 = PrivateKey.fromBytes(sk2Bytes);
  final msg = [3, 1, 4, 1, 5, 9];
  final sig1Aug = AugSchemeMPL.sign(sk1, msg);
  final sig2Aug = AugSchemeMPL.sign(sk2, msg);
  final sigAAug = AugSchemeMPL.aggregate([sig1Aug, sig2Aug]);
  print(sig1Aug.toHex() ==
      '8180f02ccb72e922b152fcedbe0e1d195210354f70703658e8e08cbebf11d4970eab6ac3ccf715f3fb876df9a9797abd0c1af61aaeadc92c2cfe5c0a56c146cc8c3f7151a073cf5f16df38246724c4aed73ff30ef5daa6aacaed1a26ecaa336b');
  print(sig2Aug.toHex() ==
      '99111eeafb412da61e4c37d3e806c6fd6ac9f3870e54da9222ba4e494822c5b7656731fa7a645934d04b559e9261b86201bbee57055250a459a2da10e51f9c1a6941297ffc5d970a557236d0bdeb7cf8ff18800b08633871a0f0a7ea42f47480');
  print(sigAAug.toHex() ==
      '8c5d03f9dae77e19a5945a06a214836edb8e03b851525d84b9de6440e68fc0ca7303eeed390d863c9b55a8cf6d59140a01b58847881eb5af67734d44b2555646c6616c39ab88d253299acc1eb1b19ddb9bfcbe76e28addf671d116c052bb1847');
}

void testPrivatekeyAddress() {
  print(ChiaWallet().masterKey ==
      '57a68b75fce26ac0bb279cf3e96f55b73da087e3eaff706c6e465244a0295d2c');
  print(ChiaWallet().publicMasterKey ==
      '869e204ef4f644cf35076915722d3864677164191b434ff397fa6680af67d5f1e050f79ee23c3e9f577b6d172de29530');
  print(ChiaWallet().getAddress("m/12381'/8444'/2'/0") ==
      'xch1r6pqmac6g7gfyu0w7rsr00lz762cevalm58gxqg0fxk7pqa03kfscmuvls');
  print(ChiaWallet().getAddress("m/12381'/8444'/2'/1") ==
      'xch1yldfr5dtcn29tz505tp8pqp9flmlaalwg34twgl9svcslhsj6f2sy8f3fu');
  print(ChiaWallet().getAddress("m/12381'/8444'/2'/2") ==
      'xch127zq20dnrpe7jhmxztuxgt9r49ndsjjlzmtweng3km53rjt0m6jsf3yjxz');
  print(ChiaWallet.checkValidAddress(
      'xch1r6pqmac6g7gfyu0w7rsr00lz762cevalm58gxqg0fxk7pqa03kfscmuvls'));
  print(ChiaWallet.getPuzzleHashFromAddress(
          'xch1r6pqmac6g7gfyu0w7rsr00lz762cevalm58gxqg0fxk7pqa03kfscmuvls') ==
      '1e820df71a47909271eef0e037bfe2f6958cb3bfdd0e83010f49ade083af8d93');
  print(ChiaWallet.getAddressFromPuzzleHash(
          '1e820df71a47909271eef0e037bfe2f6958cb3bfdd0e83010f49ade083af8d93') ==
      'xch1r6pqmac6g7gfyu0w7rsr00lz762cevalm58gxqg0fxk7pqa03kfscmuvls');
}
