# -*- mode: perl; -*-

use strict;
use warnings;

use Test::More tests => 1457;

my $class;

BEGIN { $class = 'Math::BigInt'; }
BEGIN { use_ok($class); }

my @data;
my $space = "\t\r\n ";

while (<DATA>) {
    s/#.*$//;           # remove comments
    s/\s+$//;           # remove trailing whitespace
    next unless length; # skip empty lines

    my ($in0, $out0) = split /:/;

    push @data, [ $in0, $out0 ],
                [ $in0 . $space, $out0 ],
                [ $space . $in0, $out0 ],
                [ $space . $in0 . $space, $out0 ];
}

for my $entry (@data) {
    my ($in0, $out0) = @$entry;

    # As class method.

    {
        my $x;
        my $test = qq|\$x = $class -> from_bin("$in0");|;

        eval $test;
        die $@ if $@;           # this should never happen

        subtest $test, sub {
            plan tests => 2,

            is(ref($x), $class, "output arg is a $class");
            is($x, $out0, 'output arg has the right value');
        };
    }

    # As instance method.

    {
        for my $str ("-1", "0", "1", "-inf", "+inf", "NaN") {
            my $x;
            my $test = qq|\$x = $class -> new("$str");|
                     . qq| \$x -> from_bin("$in0");|;

            eval $test;
            die $@ if $@;       # this should never happen

            subtest $test, sub {
                plan tests => 2,

                is(ref($x), $class, "output arg is a $class");
                is($x, $out0, 'output arg has the right value');
            };
        }
    }
}

__END__

0b0:0
0b1:1
0b10:2
0b11:3
0b100:4
0b101:5
0b110:6
0b111:7
0b1000:8
0b1001:9
0b1010:10
0b1011:11
0b1100:12
0b1101:13
0b1110:14
0b1111:15
0b10000:16
0b10001:17

0b11111110:254
0b11111111:255
0b100000000:256
0b100000001:257

0b1111111111111110:65534
0b1111111111111111:65535
0b10000000000000000:65536
0b10000000000000001:65537

0b111111111111111111111110:16777214
0b111111111111111111111111:16777215
0b1000000000000000000000000:16777216
0b1000000000000000000000001:16777217

0b11111111111111111111111111111110:4294967294
0b11111111111111111111111111111111:4294967295
0b100000000000000000000000000000000:4294967296
0b100000000000000000000000000000001:4294967297

0b1111111111111111111111111111111111111110:1099511627774
0b1111111111111111111111111111111111111111:1099511627775
0b10000000000000000000000000000000000000000:1099511627776
0b10000000000000000000000000000000000000001:1099511627777

0b111111111111111111111111111111111111111111111110:281474976710654
0b111111111111111111111111111111111111111111111111:281474976710655
0b1000000000000000000000000000000000000000000000000:281474976710656
0b1000000000000000000000000000000000000000000000001:281474976710657

0b11111111111111111111111111111111111111111111111111111110:72057594037927934
0b11111111111111111111111111111111111111111111111111111111:72057594037927935
0b100000000000000000000000000000000000000000000000000000000:72057594037927936
0b100000000000000000000000000000000000000000000000000000001:72057594037927937

0B10:2
b10:2
B10:2

NaN:NaN
+inf:NaN
-inf:NaN
