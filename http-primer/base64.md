[The Base16, Base32, and Base64 Data Encodings](https://tools.ietf.org/html/rfc4648)

## Base 64 Encoding

The Base 64 Alphabet

62 +
63 -
pad =

A 65-character subset of US-ASCII is used, enabling 6 bits to be represented per printable character.

The encoding process represents 24-bit groups of input bits as output strings of 4 encoded characters. Proceeding from left to right, a 24-bit input group is formed by concatenating 3 8-bit input groups. These 24 bits are then treated as 4 concatenated 6-bit groups, each of which is translated into a single character in the base 64 alphabet

Special processing is performed if fewer than 24 bits are available at the end of the data being encoded. When fewer than 24 input bits are available in an input group, bits with value zero are padded on the right to form an integral number of 6-bit groups.

The final quantum of encoding input is an integral multiple of 24 bits:
3    a     e     f    e     f    Hex
0011 10|10 1111 |0110 11|10 1111 Binary
14       47      27      47      Decimal
O        v       b       v       Base64

The final quantum of encoding input is exactly 8 bits.

The final quantum of encoding input is exactly 16 bits; the final unit of encoded output will be three characters followed by on `=` padding character.
0    7     5     4                Hex
0000 01|11 0101 |0100 00|00 0000  Binary
B       1        Q       =        Base64

## Base 64 Encoding with URL and Filename Safe Alphabet

This encoding may be refered to as `base64url`.

The encoding is tenically identical to `base64`, except for the 63 and 63 alphabet character:

62 -> -
63 -> _
