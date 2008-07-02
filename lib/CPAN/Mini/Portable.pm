package CPAN::Mini::Portable;

use 5.008;
use strict;
use warnings;
use Portable   ();
use CPAN::Mini ();

our $VERSION = '0.10';
our @ISA     = 'CPAN::Mini';

sub new {
	# Use the portable values as defaults
	my $portable = Portable->default->portable;

	# Hand off to the parent class
	my $class = shift;
	return $class->SUPER::new( %$portable, @_ );
}

1;
