use strict;
use warnings;
package Dealer;
use parent('Participant');
use Deck;
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;
use Scalar::Util qw(looks_like_number);

sub new{
  my $class = shift @_;
  # initialize name and players with passed in parameters
  my $name = shift @_;
  my $players = shift @_;
  # initialize name and players with passed in parameters
  # initialize deck and shuffle it
  my $deck = Deck->new();
  $deck->shuffle();
  my $object = bless {
    'name' => $name,
    'players' => $players,
    'deck' => $deck
  }, $class;
  return $object;
}

sub start{
  my $class = shift @_;
  # Deal two cards to each player and the dealer
  for my $i (@{$class->{'players'}}){
    $i->hit($class->{'deck'}->fetchOneCardFromTop());
    $i->hit($class->{'deck'}->fetchOneCardFromTop());
  }
  $class->hit($class->{'deck'}->fetchOneCardFromTop());
  $class->hit($class->{'deck'}->fetchOneCardFromTop());
  print "Deal two cards to all players\n";
  print BRIGHT_BLACK "Cards in all players' hand.\n";
  # Print hand information of each player and the dealer
  for my $i (@{$class->{'players'}}){
    print "Player ".$i->{'name'}."\n";
    $i->displayHand();
    my @HandValue = $i->getHandValue();
    if($HandValue[1] > 0){
      print "Total Value: ".$HandValue[0]."(hard hand) with ".$HandValue[1]." Ace.";
    }
    else{
      print "Total Value: ".$HandValue[0]." with ".$HandValue[1]." Ace.";
    }
    print "\n";
  }
  print "Dealer ".$class->{'name'}."\n";
  $class->displayHand();
  my @HandValue = $class->getHandValue();
  if($HandValue[1] > 0){
    print "Total Value: ".$HandValue[0]."(hard hand) with ".$HandValue[1]." Ace.";
  }
  else{
    print "Total Value: ".$HandValue[0]." with ".$HandValue[1]." Ace.";
  }
  print "\n";
  # each player's turn
  for my $i (@{$class->{'players'}}){
    print "*****Player ".$i->{'name'}."'s turn*****\n";
    $i->hitOrStand();
  }
  # dealer's turn
  print "*****Dealer ".$class->{'name'}."'s turn*****\n";
  # dealer's strategy here!!!!!
  my $stopHit = 0;
  my @dealerHandValue = $class->getHandValue();
  while (!$stopHit){
      $class->hit($class->{'deck'}->fetchOneCardFromTop());
      $class->displayHand();
      @dealerHandValue = $class->getHandValue();
      if($dealerHandValue[1] > 0){
        print "Total Value: ".$dealerHandValue[0]."(hard hand) with ".$dealerHandValue[1]." Ace.";
      }
      else{
        print "Total Value: ".$dealerHandValue[0]." with ".$dealerHandValue[1]." Ace.";
      }
      print "\n";
      if ($dealerHandValue[0] >= 17){
        $stopHit = 1;
      }
      if ($dealerHandValue[0] > 21){
        print BRIGHT_RED "Dealer ".$class->{'name'}." is busting.\n";
        $class->displayHand();
        print "Total value: ".$dealerHandValue[0]." with ".$dealerHandValue[1]." Ace.\n";
      }
  }
  # dealer's session ends here
  # print game information
  for my $i (@{$class->{'players'}}){
      print "#".$i->{'name'}." ";
      for my $j (@{$i->{'cards'}}){
        print $j." ";
      }
      print "\n";
  }
  print "#".$class->{'name'}." ";
  for my $i (@{$class->{'cards'}}){
    print $i." ";
  }
  print "\n";
  print "Winner between the dealer and each player.\n";
  # see who is the winner
  my $playerHighestScore = 0;
  my $dealerHighestScore = $dealerHandValue[0];
  my @eachPlayerHandValue;
  print "#";
  for my $i (@{$class->{'players'}}){
    @eachPlayerHandValue = $i->getHandValue();
    INNER:for (my $j = $eachPlayerHandValue[1];$j >= 0;$j--){
      if ($j*10+$eachPlayerHandValue[0] <= 21){
        if ($dealerHighestScore > 21){
          print $i->{'name'}." ";
          last INNER;
        }
        if ($j*10+$eachPlayerHandValue[0] > $dealerHighestScore){
          print $i->{'name'}." ";
          last INNER;
        }
        elsif ($j*10+$eachPlayerHandValue[0] <= $dealerHighestScore){
          print $class->{'name'}." ";
          last INNER;
        }
      }
      elsif ($eachPlayerHandValue[0] > 21){
        print $class->{'name'}." ";
        last INNER;
      }
    }
  }
  print "\n";
}
sub reset{
  my $class = shift @_;
  for my $i (@{$class->{'players'}}){
    $i->dropAllCards();
  }
  $class->dropAllCards();
  $class->{'deck'} = Deck->new();
  $class->{'deck'}->shuffle();
}
return 1;
