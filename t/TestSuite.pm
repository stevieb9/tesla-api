package TestSuite;

use warnings;
use strict;

use JSON;

my $file = 't/test_data/test_data.json';

sub new {
    return bless {}, shift;
}
sub data {
    my $perl;

    {
        local $/;
        open my $fh, '<', $file or die $!;
        my $json = <$fh>;
        $perl = decode_json($json);
    }

    return $perl;
}

1;