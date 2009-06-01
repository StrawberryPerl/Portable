#!/usr/bin/perl

use 5.008;
use strict;
use warnings 'all';
BEGIN {
	$|  = 1;
}

use Test::More       0.42 tests => 9;
use Test::NoWarnings 0.084;
use Test::Exception  0.27;

is( $Portable::ENABLED, undef, '$Portable::ENABLED is undef' );

require_ok( 'Portable'             );
require_ok( 'Portable::Config'     );
require_ok( 'Portable::CPAN'       );
require_ok( 'Portable::HomeDir'    );
require_ok( 'Portable::minicpan'   );
require_ok( 'CPAN::Mini::Portable' );

is( $Portable::ENABLED, undef, '$Portable::ENABLED is still undef' );
