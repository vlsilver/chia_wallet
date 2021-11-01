import 'package:chia_wallet/util/util.dart';

class ConsensusConstants {
  ///# Forks of chia should change this value to provide replay attack protection. This is set to mainnet genesis chall
  static final AGG_SIG_ME_ADDITIONAL_DATA = Util.toBytes(
      'ccd5bb71183532bff220ba46c268991a3ff07eb358e8255a65c30a2dce0e5fbb');

  ///# Max block cost in clvm cost units
  static final MAX_BLOCK_COST_CLVM = BigInt.from(11000000000);
}
