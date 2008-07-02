#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 3;
use File::Spec::Functions ':ALL';

# Override the perl path for testing purposes
$Portable::FAKE_PERL = 
$Portable::FAKE_PERL = rel2abs(
	catfile( qw{
		t data perl bin perl.exe
	} )
);

# Create a default object
use_ok( 'CPAN::Mini::Portable' );
my $object = CPAN::Mini::Portable->new(
	'local'  => 1,
	'remote' => 1,
);
isa_ok( $object, 'CPAN::Mini::Portable' );
is(
	$object->{remote},
	'http://cpan.strawberryperl.com/',
	'->remote ok',
);

1;
