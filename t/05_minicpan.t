#!/usr/bin/perl

use 5.008;
use strict;
use warnings 'all';
BEGIN {
	$|  = 1;
}

# This test requires the internet
use LWP::Online ':skip_all';

use Test::More tests => 4;
use Test::NoWarnings;
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
