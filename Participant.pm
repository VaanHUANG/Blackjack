use strict;
use warnings;

package Participant;
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;
use Scalar::Util qw(looks_like_number);
# subroutine new require TWO input: name & cards
sub new{
  my $class = shift @_;
  my $name = shift @_;
  my @cards = ();
  return bless {'name' => $name, 'cards' => \@cards}, $class;
}

# subroutine hit requires ONE input: card
sub hit{
  my $class = shift @_;
  my $card = shift @_;
  push @{$class->{'cards'}}, $card;
  print $class->{'name'}." received a card ".$card.".\n";
}

sub stand{
  print "The Player has chosen to stand.\n";
}

sub displayHand{
  my $class = shift @_;
  print "Cards in hand: ";
  for my $i (@{$class->{'cards'}}){
    print $i." ";
  }
  print "\n";
}

sub getHandValue{
  my $class = shift @_;
  my $hardSum = 0;
  my $numOfAce = 0;
  for my $i (@{$class->{'cards'}}){
    if (($i eq "J") or ($i eq "Q") or ($i eq "K")){
      $hardSum += 10;
    }
    elsif ($i eq "A") {
      $hardSum += 1;
      $numOfAce++;
    }
    else{
      $hardSum += $i;
    }
  }
  my @HandValue = ($hardSum, $numOfAce);
  return @HandValue;
}

sub dropAllCards{
  my $class = shift @_;
  my $arrSize = @{$class->{'cards'}};
  for my $i (0..$arrSize){
    shift @{$class->{'cards'}};
  }
  print "All cards dropped!\n";
}

return 1;
