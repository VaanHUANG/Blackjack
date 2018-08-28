use strict;
use warnings;
package Player;
use parent('Participant');
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;
use Scalar::Util qw(looks_like_number);

sub new{
  my $class = shift @_;
  my $name = shift @_;
  my $dealer;
  my @cards;
  my $object = bless {
    'name' => $name,
    'dealer' => $dealer,
    'cards' => \@cards
  }, $class;
  return $object;
}

sub setDealer{
  my $class = shift @_;
  my $dealer = shift @_;
  $class->{'dealer'} = $dealer;
}
return 1;
