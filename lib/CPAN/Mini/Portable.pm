package CPAN::Mini::Portable;

use 5.008;
use strict;
use warnings;
use CPAN::Mini ();
use Portable   ();

our $VERSION = '0.09';
our @ISA     = 'CPAN::Mini';

sub new {
	my $class = shift;

	# Use the portable values as defaults
	my $portable = Portable->default->portable;
	return $class->SUPER::new( %$portable, @_ );
}

1;
