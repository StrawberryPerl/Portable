#!/usr/bin/perl

use 5.008;
use strict;
use warnings 'all';
BEGIN {
	$|  = 1;
}

use Test::More tests => 41;
use Test::NoWarnings;
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
	next if $k =~ /^ld|^libpth$/;
	next unless defined $config->{$k};
	next unless length $config->{$k};
	ok( -e $config->{$k}, "$config->{$k} exists" );
}

like( $config->{libpth}, qr/^[^ ]*?\\c\\lib [^ ]*?\\c\\i686-w64-mingw32\\lib/, "$config->{libpth} check" );

ok( -e $perl->cpan->{cpan_home}, 'cpan_home exists' );
