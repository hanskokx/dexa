enum AnsiCodes {
  bold,
  dim,
  italic,
  underline,
  blinking,
  inverse,
  invisible,
  strikethrough
}

enum AnsiColors {
  black,
  red,
  green,
  yellow,
  blue,
  magenta,
  cyan,
  white,
  brightBlack,
  brightRed,
  brightGreen,
  brightYellow,
  brightBlue,
  brightMagenta,
  brightCyan,
  brightWhite,
}
enum AnsiResets {
  all,
  bold,
  dim,
  italic,
  underline,
  blinking,
  inverse,
  invisible,
  strikethrough
}
enum Args {
  longFileListing,
  humanReadableFileSize,
  showHeaders,
  listRecursively,
  listAllFiles
}

extension StringExtension on String {
  static const Map<AnsiCodes, String> ansiCodes = {
    AnsiCodes.bold: "\x1B[1m",
    AnsiCodes.dim: "\x1B[2m",
    AnsiCodes.italic: "\x1B[3m",
    AnsiCodes.underline: "\x1B[4m",
    AnsiCodes.blinking: "\x1B[5m",
    AnsiCodes.inverse: "\x1B[7m",
    AnsiCodes.invisible: "\x1B[8m",
    AnsiCodes.strikethrough: "\x1B[9m",
  };

  static const Map<AnsiColors, String> ansiForegroundColors = {
    AnsiColors.black: "\x1B[30m",
    AnsiColors.red: "\x1B[31m",
    AnsiColors.green: "\x1B[32m",
    AnsiColors.yellow: "\x1B[33m",
    AnsiColors.blue: "\x1B[34m",
    AnsiColors.magenta: "\x1B[35m",
    AnsiColors.cyan: "\x1B[36m",
    AnsiColors.white: "\x1B[37m",
    AnsiColors.brightBlack: "\x1B[90m",
    AnsiColors.brightRed: "\x1B[91m",
    AnsiColors.brightGreen: "\x1B[92m",
    AnsiColors.brightYellow: "\x1B[93m",
    AnsiColors.brightBlue: "\x1B[94m",
    AnsiColors.brightMagenta: "\x1B[95m",
    AnsiColors.brightCyan: "\x1B[96m",
    AnsiColors.brightWhite: "\x1B[97m",
  };

  static const Map<AnsiResets, String> ansiResets = {
    AnsiResets.all: "\x1B[0m",
    AnsiResets.bold: "\x1B[22m",
    AnsiResets.dim: "\x1B[22m",
    AnsiResets.italic: "\x1B[23m",
    AnsiResets.underline: "\x1B[24m",
    AnsiResets.blinking: "\x1B[25m",
    AnsiResets.inverse: "\x1B[27m",
    AnsiResets.invisible: "\x1B[28m",
    AnsiResets.strikethrough: "\x1B[29m",
  };

  String color(AnsiColors color) {
    return ansiForegroundColors[color]! + this + ansiResets[AnsiResets.all]!;
  }

  String bold() {
    return ansiCodes[AnsiCodes.bold]! + this + ansiResets[AnsiResets.bold]!;
  }

  String dim() {
    return ansiCodes[AnsiCodes.dim]! + this + ansiResets[AnsiResets.dim]!;
  }

  String italic() {
    return ansiCodes[AnsiCodes.italic]! + this + ansiResets[AnsiResets.italic]!;
  }

  String underline() {
    return ansiCodes[AnsiCodes.underline]! +
        this +
        ansiResets[AnsiResets.underline]!;
  }

  String blinking() {
    return ansiCodes[AnsiCodes.blinking]! +
        this +
        ansiResets[AnsiResets.blinking]!;
  }

  String inverse() {
    return ansiCodes[AnsiCodes.inverse]! +
        this +
        ansiResets[AnsiResets.inverse]!;
  }

  String invisible() {
    return ansiCodes[AnsiCodes.invisible]! +
        this +
        ansiResets[AnsiResets.invisible]!;
  }

  String strikethrough() {
    return ansiCodes[AnsiCodes.strikethrough]! +
        this +
        ansiResets[AnsiResets.strikethrough]!;
  }
}
