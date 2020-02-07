# NAME

Portable - Perl on a Stick

# SYNOPSIS

Launch a script portably

    F:\anywhere\perl.exe -MPortable script.pl

Have a script specifically request to run portably

    #!/usr/bin/perl
    use Portable;

# DESCRIPTION

"Portable" is a term used for applications that are installed onto a
portable storage device (most commonly a USB memory stick) rather than
onto a single host.

This technique has become very popular for Windows applications, as it
allows a user to make use of their own software on typical publically
accessible computers at libraries, hotels and internet cafes.

Converting a Windows application into portable form has a specific set
of challenges, as the application has no access to the Windows registry,
no access to "My Documents" type directories, and does not exist at a
reliable filesystem path (because the portable storage medium can be
mounted at an arbitrary volume or filesystem location).

**Portable** provides a methodology and implementation to support
the creating of "Portable Perl" applications and distributions.

While this will initially be focused on a Windows implementation,
wherever possible the module will be built to be platform-agnostic
in the hope that future versions can support other operating systems,
or work across multiple operating systems.

This module is not ready for public use. For now, see the code for
more details on how it works...

# METHODS

# AUTHOR

Adam Kennedy <adamk@cpan.org>

# COPYRIGHT

Copyright 2008 - 2011 Adam Kennedy.

This program is free software; you can redistribute
it and/or modify it under the same terms as Perl itself.

The full text of the license can be found in the
LICENSE file included with this module.
