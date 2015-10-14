# Pragmas.
use strict;
use warnings;

# Modules.
use inc::Module::Install;

# Definition.
abstract 'Create and manipulate volume widgets.';
author 'Michal Spacek <skim@cpan.org>';
license 'bsd';
name 'Curses-UI-Volume';
readme_from 'Volume.pm';
requires 'Curses::UI' => 0;
requires 'Encode' => 0;
requires 'Readonly' => 0;
requires 'perl' => '5.6.0';
resources 'bugtracker' => 'https://rt.cpan.org/Public/Dist/Display.html'.
	'?Name=Curses-UI-Volume';
resources 'homepage' => 'https://github.com/tupinek/Curses-UI-Volume';
resources 'repository' => 'git://github.com/tupinek/Curses-UI-Volume';
test_requires 'English' => 0;
test_requires 'File::Object' => 0.08;
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
test_requires 'Test::Pod' => 0;
test_requires 'Test::Pod::Coverage' => 0;
tests_recursive;
version '0.02';

# Run.
WriteAll();
