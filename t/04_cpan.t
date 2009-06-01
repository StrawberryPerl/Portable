#!/usr/bin/perl

use 5.008;
use strict;
use warnings 'all';
BEGIN {
	$|  = 1;
}

use Test::More tests => 2;
use Test::NoWarnings;
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
