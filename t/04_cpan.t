#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 1;
use File::Spec::Functions ':ALL';
use Class::Inspector ();

# Override the perl path for testing purposes
$Portable::FAKE_PERL = 
$Portable::FAKE_PERL = rel2abs(
	catfile( qw{
		t data perl bin perl.exe
	} )
);

SKIP: {
	unless ( Class::Inspector->installed('CPAN::Config') ) {
		skip( "CPAN::Config not found", 1 );
	}
	eval {
		require Portable;
		Portable->import('CPAN');
	};
	ok( ! $@, '->import(CPAN) ok' );
}
