package Tesla::Vehicles;

use warnings;
use strict;

use parent 'Tesla::API';

use Data::Dumper;

our $VERSION = '0.03';

sub new {
    my ($class, %params) = @_;

    my $self = $class->SUPER::new(%params);

    print Dumper $self;
}

1;
