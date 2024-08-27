use warnings;
use strict;

use Data::Dumper;
use Tesla::API;
use Tesla::Vehicle;
use feature 'say';

my $tesla = Tesla::API->new;

#$tesla->useragent_timeout(0.1);

#print Dumper $tesla->api(endpoint => 'VEHICLE_LIST');
#say "endpoint: " . $tesla->_api_attempts;
