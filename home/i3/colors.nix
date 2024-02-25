{ colors }:
let
  mapI3Variable = name: value: {
    "${"$"}${name}" = "0xff${builtins.substring 1 6 value}";
  };
in builtins.foldl' (acc: name: acc // (mapI3Variable name colors.${name})) { }
(builtins.attrNames colors)
