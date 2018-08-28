use strict;
use warnings;
package AIPlayer;
use parent('Player');
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;
use Scalar::Util qw(looks_like_number);

sub hitOrStand{
  # AI strategy here!!!!!
  my $class = shift @_;
  my @AIHandValue = $class->getHandValue();
  if ($AIHandValue[0] == 21){
    $class->stand();
  }
  # if AI has Aces in its hand
  else{
    my $softHV = $AIHandValue[0] + 10*$AIHandValue[1];
    if ($AIHandValue[0] > 21){
      print BRIGHT_RED "Player ".$class->{'name'}." is busting.\n";
    }
    if ($softHV > 21 && $AIHandValue[0] <= 10){# if AI has got two or more As but low hard value
      $class->hit($class->{'dealer'}->{'deck'}->fetchOneCardFromTop());
      $class->hitOrStand();
    }
    elsif ($softHV > 21 && $AIHandValue[0] > 10 && $AIHandValue[0] < 17){
      $class->hit($class->{'dealer'}->{'deck'}->fetchOneCardFromTop());
      $class->hitOrStand();
    }
    elsif ($softHV > 21 || $AIHandValue[0] > 17){
        $class->stand();
    }
    else{
      $class->hit($class->{'dealer'}->{'deck'}->fetchOneCardFromTop());
      $class->hitOrStand();
    }
  }
}
return 1;
