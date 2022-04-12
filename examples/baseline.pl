use warnings;
use strict;

use Data::Dumper;
use Tesla::API;
use Tesla::Vehicle;
use feature 'say';

my $tesla = Tesla::API->new;
my $car = Tesla::Vehicle->new;

$tesla->api(endpoint => 'VEHICLE_SUMMARY', id => $car->id);
$tesla->api(endpoint => 'VEHICLE_SUMMARY', id => $car->id);
$tesla->api(endpoint => 'VEHICLE_SUMMARY', id => $car->id);
$tesla->api(endpoint => 'VEHICLE_SUMMARY', id => $car->id);
$tesla->api(endpoint => 'VEHICLE_SUMMARY', id => $car->id);
$tesla->api(endpoint => 'VEHICLE_SUMMARY', id => $car->id);

sleep 5;
$tesla->api(endpoint => 'VEHICLE_SUMMARY', id => $car->id);
