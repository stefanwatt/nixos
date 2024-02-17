{ colors }:
let
  hexToArgb = name: value: {
    "${"$"}${name}" = "rgb(${builtins.substring 1 6 value})";
  };
in builtins.foldl' (acc: name: acc // (hexToArgb name colors.${name})) { }
(builtins.attrNames colors)
