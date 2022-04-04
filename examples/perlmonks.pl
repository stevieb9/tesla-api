use warnings;
use strict;

use Tesla::Vehicle;

my $car = Tesla::Vehicle->new(auto_wake => 1);

printf(
    "My Tesla account has my car registered with the name '%s'.\n",
    $car->name
);

my $gear = $car->gear;
my $speed = $car->speed;
my $odo = $car->odometer;

printf(
    "My car is in gear %s and is currently going %d MPH and my odometer is %d\n",
    $gear,
    $speed,
    $odo,
);

printf(
    "My latitude is %f, longitide is %f, my heading is %d degrees and its using %.2f kWh/mile\n",
    $car->latitude,
    $car->longitude,
    $car->heading,
    $car->power
);

printf(
    "My dashcam is %s, sentry mode is %s and I %s currently near my vehicle\n",
    $car->dashcam,
    $car->sentry_mode ? 'enabled' : 'disabled',
    $car->user_present ? 'am' : 'am not'
);

printf(
    "My battery is at %d%%, and is %s charging at %.2f volts pulling %.2f Amps\n",
    $car->battery_level,
    $car->charging_state ? 'currently' : 'not',
    $car->charger_voltage,
    $car->charge_actual_current
);

if ($car->battery_level >= $car->charge_limit_soc) {
    print "The charger is connected but disabled due to set maximum charge level reached\n";
}

printf(
    "My steering wheel warmer is %s, passenger seat warmer is %s, and Bio Weapon mode is %s\n",
    $car->heater_steering_wheel ? 'on' : 'off',
    $car->heater_seat_passenger ? 'on' : 'off',
    $car->bioweapon_mode ? 'on' : 'off'
);

printf(
    "The temperature inside the car is %dC and outside it's %dC, and climate control is %s\n",
    $car->temperature_inside,
    $car->temperature_outside,
    $car->is_climate_on ? 'on' : 'off'
);