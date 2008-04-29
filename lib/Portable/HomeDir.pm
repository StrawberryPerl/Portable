package Portable::HomeDir;

use 5.008;
use strict;
use warnings;
use Carp         ();
use Scalar::Util ();

our $VERSION = '0.06';
our @ISA     = ();





#####################################################################
# Portable Driver API

sub new {
	my $class  = shift;
	my $parent = shift;
	unless ( Portable::_HASH($parent->portable_homedir) ) {
		Carp::croak('Missing or invalid HomeDir key in portable.perl');
	}

	# Create the object
	my $self = bless { }, $class;

	# Map the 
	my $homedir = $parent->portable_homedir;
	my $root    = $parent->dist_root;
	foreach my $key ( sort keys %$homedir ) {
		unless (
			defined $homedir->{$key}
			and
			length $homedir->{$key}
		) {
			$self->{$key} = $homedir->{$key};
			next;
		}
		$self->{$key} = File::Spec->catdir(
			$root, split /\//, $homedir->{$key}
		);
	}
	my $homedir = $parent->homedir;

	return $self;
}

sub apply {
	my $self   = shift;

	# This won't work if File::HomeDir is already loaded
	if ( $File::HomeDir::VERSION ) {
		croak("File::HomeDir is already loaded");
	}

	# Load File::HomeDir and the regular platform driver
	use File::HomeDir;

	# Remember the platform we're on so we can default
	# to it properly if there's no portable equivalent.
	$self->{platform} = $File::HomeDir::ISA[0];

	# Hijack the implementation class to us
	$File::HomeDir::IMPLEMENTED_BY = Scalar::Util::blessed($self);

	return 1;
}

sub platform {
	$_[0]->{platform};
}





#####################################################################
# File::HomeDir::Driver API

sub _SELF {
	ref($_[0]) ? $_[0] : Portable->default->homedir;
}

sub my_home {
	_SELF(shift)->{my_home};
}

sub my_desktop {
	shift->my_home;
}

sub my_documents {
	shift->my_home;
}

sub my_data {
	shift->my_home;
}

sub my_music {
	shift->my_home;
}

sub my_pictures {
	shift->my_home;
}

sub my_videos {
	shift->my_home;
}

1;
