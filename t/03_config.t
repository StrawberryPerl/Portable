#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 2;
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
ok( ! $@, "->import(Config) ok" );

# CPAN::Config should not be loaded
ok( ! $INC{'CPAN/Config.pm'}, 'CPAN::Config is not loaded' );
