
use strict;
use warnings;

use_ok(Results);

ok(my $r=Results->new);
ok($r->readfile("etc/results.csv"));