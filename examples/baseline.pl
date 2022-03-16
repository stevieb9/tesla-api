use warnings;
use strict;

use Data::Dumper;
use Tesla::API;
use feature 'say';

my $tesla = Tesla::API->new;

say $tesla->my_vehicle_name;

print Dumper $tesla->vehicle_data;