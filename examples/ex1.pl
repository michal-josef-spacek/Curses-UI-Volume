#!/usr/bin/env perl

# Pragmas.
use strict;
use warnings;

# Modules.
use Curses::UI;

# Object.
my $cui = Curses::UI->new;

# Main window.
my $win = $cui->add('window_id', 'Window');

# Add volume.
$win->add(
        undef, 'Curses::UI::Volume',
        '-volume' => 50,
);

# Binding for quit.
$win->set_binding(\&exit, "\cQ", "\cC");

# Loop.
$cui->mainloop;