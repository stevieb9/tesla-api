use warnings;
use strict;
use feature 'say';

use Data::Dumper;
use Tesla::Vehicle;

my $v = Tesla::Vehicle->new;

say $v->charge_limit_soc;
say $v->charge_limit_soc_min;
say $v->charge_limit_soc_std;
say $v->charge_limit_soc_max;

1;
