use warnings;
use strict;

use Tesla::API;

my $t = Tesla::API->new;

$t->update_data_files;
