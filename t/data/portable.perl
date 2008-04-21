---
class: Portable
cpan:
  build_dir: cpan/build
  cpan_home: cpan
  histfile: cpan/histfile
  keep_source_where: cpan/sources
  make: c/bin/dmake.exe
  makepl_arg: 'LIBS=-L$libpth INC=-I$incpath'
  prefs_dir: cpan/prefs
minicpan:
  local: minicpan
config:
  archlib: perl/lib
  archlibexp: perl/lib
  bin: perl/bin
  binexp: perl/bin
  incpath: c/include
  installarchlib: perl/lib
  installbin: perl/bin
  installbin: perl/bin
  installhtml1dir: ''
  installhtml3dir: ''
  installhtmldir: perl/html
  installhtmlhelpdir: perl/htmlhelp
  installman1dir: perl/man/man1
  installman3dir: perl/man/man3
  installprefix: perl
  installprefixexp: perl
  installprivlib: perl/lib
  installscript: perl/bin
  installsitearch: perl/site/lib
  installsitebin: perl/bin
  installsitehtml1dir: ''
  installsitehtml3dir: ''
  installsitelib: perl/site/lib
  installsiteman1dir: ''
  installsiteman3dir: ''
  installsitescript: ''
  installstyle: lib
  installusrbinperl: ~
  installvendorarch: ''
  installvendorbin: ''
  installvendorhtml1dir: ''
  installvendorhtml3dir: ''
  installvendorlib: ''
  installvendorman1dir: ''
  installvendorman3dir: ''
  installvendorscript: ''
  lddlflags: '-mdll -s -L"$archlib\CORE" -L"$libpth"'
  ldflags: '-s -L"$archlib\CORE" -L"$libpth"'
  libpth: c/lib
  perlpath: perl/bin/perl.exe
  prefix: perl
  privlibexp: perl/lib
  scriptdir: perl/bin
  sitearchexp: perl/site/lib
  sitelibexp: perl/site/lib
  man1dir: perl/man/man1
  man1direxp: perl/man/man1
  man3dir: perl/man/man3
  man3direxp: perl/man/man3
ENV:
  PATH:
    - c/bin
    - perl/bin
  LIB:
    - c/lib
    - perl/bin
  INCLUDE:
    - c/include
    - perl/lib/CORE
