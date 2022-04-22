use warnings;
use strict;

use File::Copy;
use FindBin qw($RealBin);

my $endpoints_file;
my $optcodes_file;

BEGIN {
    $endpoints_file = "$RealBin/test_data/endpoints_new.json";
    $optcodes_file = "$RealBin/test_data/optcodes_new.json";

    for ($endpoints_file, $optcodes_file) {
        open my $fh, '>', $_ or die $!;
        print $fh "{}";
    }

    $ENV{TESLA_API_ENDPOINTS_FILE} = $endpoints_file;
    $ENV{TESLA_API_OPTIONCODES_FILE} = $optcodes_file;
}

use lib 't/';

use Data::Dumper;
use JSON;
use Mock::Sub;
use Tesla::API;
use Test::More;
use TestSuite;

my $t = Tesla::API->new(unauthenticated => 1);
my $ts = TestSuite->new;
my $ms = Mock::Sub->new;

my $endpoints = $ts->file_data('t/test_data/endpoints.json');
my $optcodes = $ts->file_data('t/test_data/option_codes.json');

my $api_sub = $ms->mock('Tesla::API::_tesla_api_call');

for my $type ('endpoints', 'option_codes') {
    is keys %{ $t->$type }, 0, "$type has no entries ok";

    my $return = $type eq 'endpoints'
        ? encode_json($endpoints)
        : encode_json($optcodes);

    $api_sub->return_value(
        1,
        200,
        $return
    );

    $t->update_data_files($type);

    my $api_endpoints = $t->endpoints;
    my $api_options = $t->option_codes;


    if ($type eq 'endpoints') {
        is keys %{ $api_endpoints } > 0, 1, "Updated $type file has entries ok";

        is
            keys %$api_endpoints,
            keys %$endpoints,
            "endpoints() returns the proper number of endpoints ok";

        for my $endpoint (keys %$endpoints) {
            for (keys %{$endpoints->{$endpoint}}) {
                is
                    $api_endpoints->{$endpoint}{$_},
                    $endpoints->{$endpoint}{$_},
                    "Attribute $_ for endpoint $endpoint is $endpoints->{$endpoint}{$_} ok";
            }
        }
    }
    else {
        is keys %{ $api_options } > 0, 1, "Updated $type file has entries ok";

        is
            keys %$api_options,
            keys %$optcodes,
            "option_codes() returns the proper number of option codes ok";

        for my $option (keys %$optcodes) {
            is
                $api_options->{$option},
                $optcodes->{$option},
                "Value for option $option is correct";

            is
                $t->option_codes($option),
                $optcodes->{$option},
                "Value for option $option is correct via option_codes($option)";
        }
    }
}

my $endpoints_end = $ts->file_data($endpoints_file);
my $optcodes_end = $ts->file_data($optcodes_file);

is keys %{$endpoints_end} > 0, 1, "Updated endpoints file has entries ok";
is keys %{$optcodes_end} > 0, 1, "Updated optcodes file has entries ok";

unlink $endpoints_file or die $!;
unlink $optcodes_file or die $!;

my @files = glob 't/test_data/*.json.*';

is scalar @files, 2, "Proper number of file backups ok";

for (@files) {
    unlink $_ or die !$;
}

done_testing();