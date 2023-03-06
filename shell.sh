#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash


for x in {0..1}; do
  for y in {0..99}; do
    if [ `expr $y % 2` -eq 0 ]; then
      printf "$x.$y,"
    fi
  done
done
echo ""
