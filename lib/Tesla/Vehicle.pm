package Tesla::Vehicle;

use warnings;
use strict;

use parent 'Tesla::API';

use Carp qw(croak confess);
use Data::Dumper;

our $VERSION = '0.03';

# Object Related

sub new {
    my ($class, %params) = @_;
    my $self = $class->SUPER::new(%params);

    $self->_id($params{id});

    return $self;
}
sub data {
    my ($self) = @_;
    return $self->api('VEHICLE_DATA', $self->id);
}

# Vehicle Identification

sub id {
    # Tries to figure out the ID to use in API calls
    my ($self, $id) = @_;

    if (! defined $id) {
        $id = $self->_id;
    }

    if (! $id) {
        confess "Method called that requires an \$id param, but it wasn't sent in";
    }

    return $id;
}
sub list {
    my ($self) = @_;

    return $self->{vehicles} if $self->{vehicles};

    my $vehicles = $self->api('VEHICLE_LIST');

    for (@$vehicles) {
        $self->{data}{vehicles}{$_->{id}} = $_->{display_name};
    }

    return $self->{data}{vehicles};
}
sub name {
    my ($self) = @_;
    return $self->list->{$self->id};
}

# Top Level Data Structures

sub vehicle_state {
    return $_[0]->data->{vehicle_state};
}
sub charge_state {
    return $_[0]->data->{charge_state};
}

# Vehicle State

sub odometer {
    return $_[0]->data->{vehicle_state}{odometer};
}
sub sentry_mode {
    return $_[0]->data->{vehicle_state}{sentry_mode};
}
sub santa_mode {
    return $_[0]->data->{vehicle_state}{santa_mode};
}

# Charge State

sub battery_level {
    return $_[0]->data->{charge_state}{battery_level};
}
sub charging_state {
    return $_[0]->data->{charge_state}{charging_state};
}
sub charge_amps {
    return $_[0]->data->{charge_state}{charge_amps};
}
sub charge_actual_current {
    return $_[0]->data->{charge_state}{charge_actual_current};
}
sub charge_limit_soc {
    return $_[0]->data->{charge_state}{charge_limit_soc};
}
sub charge_limit_soc_std {
    return $_[0]->data->{charge_state}{charge_limit_soc_std};
}
sub charge_limit_soc_min {
    return $_[0]->data->{charge_state}{charge_limit_soc_min};
}
sub charge_limit_soc_max {
    return $_[0]->data->{charge_state}{charge_limit_soc_max};
}
sub charge_port_color {
    return $_[0]->data->{charge_state}{charge_port_color};
}
sub charger_voltage {
    return $_[0]->data->{charge_state}{charger_voltage};
}
sub minutes_to_full_charge {
    return $_[0]->data->{charge_state}{minutes_to_full_charge};
}

# Command Related

sub wake {
    my ($self) = @_;
}

# Private

sub _id {
    my ($self, $id) = @_;

    return $self->{data}{vehicle_id} if $self->{data}{vehicle_id};

    if (defined $id) {
        $self->{data}{vehicle_id} = $id;
    }
    else {
        my @vehicle_ids = keys %{$self->list};
        $self->{data}{vehicle_id} = $vehicle_ids[0];
    }

    return $self->{data}{vehicle_id} || -1;
}
1;

=head1 NAME

Tesla::Vehicle - Access information about your Tesla automobile via the API

=head1 DESCRIPTION


=head1 AUTHOR

Steve Bertrand, C<< <steveb at cpan.org> >>

=head1 LICENSE AND COPYRIGHT

Copyright 2022 Steve Bertrand.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>