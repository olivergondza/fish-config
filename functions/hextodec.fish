function hextodec --description "Convert hexadecimal to decimal"
  bash -c 'echo $((0x'$argv[1]'))'
end
