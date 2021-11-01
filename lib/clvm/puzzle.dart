import 'package:chia_wallet/clvm/program.dart';
import 'package:chia_wallet/core/ec.dart';
import 'package:chia_wallet/core/fields.dart';
import 'package:convert/convert.dart';

class Puzzle {
  static Program get DEFAULTHIDDENPUZZLE =>
      Program.fromBytes(hex.decode('ff0980'));
  static List<int> get DEFAULTHIDDENPUZZLEHASH =>
      Program.sha256Treehash(DEFAULTHIDDENPUZZLE, null);

  static List<int> createPuzzlehashForPk(JacobianPoint publicKey) {
    return Program.sha256Treehash(puzzleForPk(publicKey), null);
  }

  static Program puzzleForPk(JacobianPoint publicKey) {
    return puzzleForPublicKeyAndHIddenPuzzleHash(
        publicKey, DEFAULTHIDDENPUZZLEHASH);
  }

  static JacobianPoint caculateSyntheticPublicKey(
    JacobianPoint publicKey,
    List<int> hiddenPuzzleHash,
  ) {
    final sys = Program.SYNTHETICMOD;
    final r = sys.run([publicKey.toBytes(), hiddenPuzzleHash]);
    return JacobianPoint.fromBytes(r.atom!, Fq);
  }

  static Program puzzleForPublicKeyAndHIddenPuzzleHash(
    JacobianPoint publicKey,
    List<int> hiddenPuzzleHash,
  ) {
    final syntheticPubkeyKey =
        caculateSyntheticPublicKey(publicKey, hiddenPuzzleHash);
    return puzzleForSyntheticPublicKey(syntheticPubkeyKey);
  }

  static Program puzzleForSyntheticPublicKey(JacobianPoint syntheticPublicKey) {
    return Program.MOD.curry(syntheticPublicKey.toBytes());
  }

  static Program puzzleForConditions(List<dynamic> conditions) {
    return Program.MOD_SIGN.run([conditions]);
  }

  static solutionForDelegatedPuzzle({
    required Program delegatedPuzzle,
    required Program solution,
  }) {
    return Program.to([[], delegatedPuzzle, solution]);
  }

  static Program solutionFoConditions(List<dynamic> conditions) {
    var delegatedPuzzle = puzzleForConditions(conditions);
    return solutionForDelegatedPuzzle(
      delegatedPuzzle: delegatedPuzzle,
      solution: Program.to(0),
    );
  }

  static Program puzzleForPuzzleHash(JacobianPoint publicKey) {
    return puzzleForPk(publicKey);
  }

  // Future<JacobianPoint> hackPopulateSecretKeyForPuzzleHash(List<int> puzzleHash) {
  //   var
  // }

}
