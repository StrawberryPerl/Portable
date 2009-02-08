#!/usr/bin/perl

use strict;
BEGIN {
	$|  = 1;
	$^W = 1;
}

use Test::More tests => 38;
use File::Spec ();

# Override the perl path for testing purposes
$Portable::FAKE_PERL =
$Portable::FAKE_PERL = File::Spec->rel2abs(
	File::Spec->catfile( qw{
		t data perl bin perl.exe
	} )
);

require_ok( 'Portable' );
ok( $Portable::FAKE_PERL, 'FAKE_PERL remains defined' );
ok( ! $INC{'CPAN/Config.pm'}, 'CPAN::Config is not loaded' );

# Create an object
my $perl = Portable->default;
isa_ok( $perl, 'Portable' );

# Twice to avoid a warning
is( $Portable::ENABLED, undef, '$Portable::ENABLED is true' );
is( $Portable::ENABLED, undef, '$Portable::ENABLED is true' );

# Do all the config entries exist
my $config = $perl->config;
foreach my $k ( sort keys %$config ) {
	next if $k =~ /^ld/;
	next unless defined $config->{$k};
	next unless length $config->{$k};
	ok( -e $config->{$k}, "$config->{$k} exists" );
}

ok( -e $perl->cpan->{cpan_home}, 'cpan_home exists' );
