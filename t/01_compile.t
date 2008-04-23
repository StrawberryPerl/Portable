#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 4;

ok( $] >= 5.008, 'Perl version is new enough' );

require_ok( 'Portable'         );
require_ok( 'Portable::Config' );
require_ok( 'Portable::CPAN'   );
