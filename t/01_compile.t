#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 9;

ok( $] >= 5.008, 'Perl version is new enough' );

is( $Portable::ENABLED, undef, '$Portable::ENABLED is undef' );

require_ok( 'Portable'             );
require_ok( 'Portable::Config'     );
require_ok( 'Portable::CPAN'       );
require_ok( 'Portable::HomeDir'    );
require_ok( 'Portable::minicpan'   );
require_ok( 'CPAN::Mini::Portable' );

is( $Portable::ENABLED, undef, '$Portable::ENABLED is still undef' );
