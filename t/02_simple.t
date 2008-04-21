#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 1;
use File::Spec ();
use Portable   ();

# Override the perl path for testing purposes
$Portable::FAKE_PERL = File::Spec->rel2abs(
	File::Spec->catfile( qw{
		t data perl bin perl.exe
	} )
);

# Create an object
my $perl = Portable->_default;
isa_ok( $perl, 'Portable' );
