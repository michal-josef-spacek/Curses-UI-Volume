package Curses::UI::Volume;

# Pragmas.
use Curses::UI::Widget;
use base qw(Curses::UI::ContainerWidget);
use strict;
use warnings;

# Modules.
use Curses;
use Curses::UI::Common;
use Curses::UI::Label;
use Encode qw(decode_utf8);
use Readonly;

# Constants.
Readonly::Scalar our $FULL_BLOCK => decode_utf8('█');
Readonly::Scalar our $LEFT_SEVEN_EIGHTS_BLOCK => decode_utf8('▉');
Readonly::Scalar our $LEFT_THREE_QUARTERS_BLOCK => decode_utf8('▊');
Readonly::Scalar our $LEFT_FIVE_EIGHTS_BLOCK => decode_utf8('▋');
Readonly::Scalar our $LEFT_HALF_BLOCK => decode_utf8('▌');
Readonly::Scalar our $LEFT_THREE_EIGHTS_BLOCK => decode_utf8('▍');
Readonly::Scalar our $LEFT_ONE_QUARTER_BLOCK => decode_utf8('▎');
Readonly::Scalar our $LEFT_ONE_EIGHTH_BLOCK => decode_utf8('▏');

# Version.
our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, %userargs) = @_;
	keys_to_lowercase(\%userargs);
	my %args = (
		'-volume' => 0,
		'-fg' => 'white',
		'-bg' => 'black',
		%userargs,
		'-volume_width' => undef,
		'-focusable' => 0,
	);

	# Height and width.
	$args{'-height'} = height_by_windowscrheight(1, %args);
	if (! exists $args{'-width'}) {
		$args{'-width'} = width_by_windowscrwidth(3, %args);
	}

	# Create the widget.
	my $self = $class->SUPER::new(%args);

	# Volume effective area.
	$self->{'-volume_width'} = $self->width;
	if ($self->{'-border'} || $self->{'-sbborder'}) {
		$self->{'-volume_width'} -= 2;
	}

	# Adapter widget.
	$self->add(
		'volume', 'Label',
		'-bg' => $self->{'-bg'},
		'-fg' => $self->{'-fg'},
		'-text' => $self->_volume($self->{'-volume'}),
		'-width' => $args{'-width'} - 1,
	);

	# Layout.
	$self->layout;

	# Return object.
	return $self;
}

# Get or set volume.
sub volume {
	my ($self, $volume) = @_;
	if (defined $volume) {
		$self->{'-volume'} = $volume;
		$self->getobj('volume')->text($self->_volume($volume));
	}
	return $self->{'-volume'};
}

# Set text label.
sub _volume {
	my ($self, $volume) = @_;
	my $parts = $self->{'-volume_width'} * 8;
	my $vol_parts = $volume / 100 * $parts;
	my $vol_blocks = int($vol_parts / 8);
	my $vol_other = $vol_parts % 8;
	my $other_char = '';
	if ($vol_other == 1) {
		$other_char = $LEFT_ONE_EIGHTH_BLOCK;
	} elsif ($vol_other == 2) {
		$other_char = $LEFT_ONE_QUARTER_BLOCK;
	} elsif ($vol_other == 3) {
		$other_char = $LEFT_THREE_EIGHTS_BLOCK;
	} elsif ($vol_other == 4) {
		$other_char = $LEFT_HALF_BLOCK;
	} elsif ($vol_other == 5) {
		$other_char = $LEFT_FIVE_EIGHTS_BLOCK;
	} elsif ($vol_other == 6) {
		$other_char = $LEFT_THREE_QUARTERS_BLOCK;
	} elsif ($vol_other == 7) {
		$other_char = $LEFT_SEVEN_EIGHTS_BLOCK;
	}
	return ($FULL_BLOCK x $vol_blocks).$other_char;
}

1;
