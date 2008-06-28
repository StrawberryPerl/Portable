package CPAN::Mini::Portable;

use 5.008;
use strict;
use warnings;
use base 'CPAN::Mini';
use Portable ();

our $VERSION = '0.06';

sub new {
	my $class = shift;

	# Use the portable values as defaults
	my $portable = Portable->default->portable;
	return $class->SUPER::new( %$portable, @_ );
}

1;