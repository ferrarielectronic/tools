import 'block_parser.dart';
import 'inline_parser.dart';

class ExtensionSet {
  static ExtensionSet none = new ExtensionSet._([], []);

  static ExtensionSet commonMark = new ExtensionSet._(
      [const FencedCodeBlockSyntax()], [new InlineHtmlSyntax()]);

  final List<BlockSyntax> blockSyntaxes;
  final List<InlineSyntax> inlineSyntaxes;

  ExtensionSet._(this.blockSyntaxes, this.inlineSyntaxes);
}
