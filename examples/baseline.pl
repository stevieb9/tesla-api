use warnings;
use strict;

use Data::Dumper;
use Tesla::API;
use Tesla::Vehicle;
use feature 'say';

my $tesla = Tesla::API->new;
say "new: " . $tesla->_api_attempts;
my $car = Tesla::Vehicle->new;

say $tesla->api(endpoint => 'VEHICLE_SUMMARY', id => $car->id);
say "endpoint: " . $tesla->_api_attempts;
