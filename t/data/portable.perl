---
CPAN:
  build_dir: cpan/build
  cpan_home: cpan
  histfile: cpan/histfile
  keep_source_where: cpan/sources
  make: c/bin/dmake.exe
  makepl_arg: 'LIBS=-L$libpth INC=-I$incpath'
  patch: c/bin/patch.exe
  prefs_dir: cpan/prefs
MiniCPAN:
  local: minicpan
Config:
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
  installhtmldir: ''
  installhtmlhelpdir: ''
  installman1dir: ''
  installman3dir: ''
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
  installstyle: perl/lib
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
  ldflags_nolargefiles: '-s -L"$archlib\CORE" -L"$libpth"'
  libpth: c/lib
  perlpath: perl/bin/perl.exe
  prefix: perl
  prefixexp: perl
  privlib: perl/lib
  privlibexp: perl/lib
  scriptdir: perl/bin
  scriptdirexp: perl/bin
  sitearch: perl/site/lib
  sitearchexp: perl/site/lib
  sitebin: perl/site/bin
  sitebinexp: perl/site/bin
  sitelib: perl/site/lib
  sitelibexp: perl/site/lib
  siteprefix: perl/site
  siteprefixexp: perl/site
  man1dir: ''
  man1direxp: ''
  man3dir: ''
  man3direxp: ''
Env:
  PATH:
    - c/bin
    - perl/bin
  LIB:
    - c/lib
    - perl/bin
  INCLUDE:
    - c/include
    - perl/lib/CORE
