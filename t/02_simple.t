#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 33;
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

# Do all the config entries exist
my $config = $perl->config;
foreach my $k ( sort keys %$config ) {
	next if $k =~ /^ld/;
	next unless defined $config->{$k};
	next unless length $config->{$k};
	ok( -e $config->{$k}, "$config->{$k} exists" );
}

ok( -e $perl->cpan->{cpan_home}, 'cpan_home exists' );
