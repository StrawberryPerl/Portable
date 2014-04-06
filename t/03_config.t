#!/usr/bin/perl

use 5.008;
use strict;
use warnings 'all';
BEGIN {
	$|  = 1;
}

use Test::More tests => 5;
use Test::NoWarnings;
use Test::Exception;
use File::Spec ();

# Override the perl path for testing purposes
$Portable::FAKE_PERL = 
$Portable::FAKE_PERL = File::Spec->rel2abs(
	File::Spec->catfile( qw{
		t data perl bin perl.exe
	} )
);

eval {
	require Portable;
	Portable->import('Config');
};
warn "XXXXX: $@" if $@;
ok( ! $@, "->import(Config) ok" );

# CPAN::Config should not be loaded
ok( ! $INC{'CPAN/Config.pm'}, 'CPAN::Config is not loaded' );

# We are now enabled (twice to avoid a warning)
is( $Portable::ENABLED, 1, '$Portable::ENABLED is true' );
is( $Portable::ENABLED, 1, '$Portable::ENABLED is true' );
