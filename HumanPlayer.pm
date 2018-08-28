use strict;
use warnings;
package HumanPlayer;
use parent('Player');
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;
use Scalar::Util qw(looks_like_number);

sub hitOrStand{
  my $class = shift @_;
  print BRIGHT_BLACK "'h' to hit, 's' to stand\n";
  my $action = <STDIN>;
  chomp $action;
  while ($action ne 'h' && $action ne 's'){
    print BRIGHT_RED "Invalid input!Try again;)\n";
    print BRIGHT_BLACK "'h' to hit, 's' to stand\n";
    $action = <STDIN>;
    chomp $action;
  }
  if ($action eq 'h'){
    $class->hit($class->{'dealer'}->{'deck'}->fetchOneCardFromTop());
    $class->displayHand();
    my @playerHandValue = $class->getHandValue();
    if($playerHandValue[1] > 0){
      print "Total Value: ".$playerHandValue[0]."(hard hand) with ".$playerHandValue[1]." Ace.";
    }
    else{
      print "Total Value: ".$playerHandValue[0]." with ".$playerHandValue[1]." Ace.";
    }
    print "\n";
    if ($playerHandValue[0] > 21){
      print BRIGHT_RED "Player ".$class->{'name'}." is busting.\n";
      $class->displayHand();
      @playerHandValue = $class->getHandValue();
      if($playerHandValue[1] > 0){
        print "Total Value: ".$playerHandValue[0]."(hard hand) with ".$playerHandValue[1]." Ace.";
      }
      else{
        print "Total Value: ".$playerHandValue[0]." with ".$playerHandValue[1]." Ace.";
      }
      print "\n";
    }
    else{
      $class->hitOrStand();
    }
  }
  else{
    $class->stand();
    $class->displayHand();
    my @playerHandValue = $class->getHandValue();
    if($playerHandValue[1] > 0){
      print "Total Value: ".$playerHandValue[0]."(hard hand) with ".$playerHandValue[1]." Ace.";
    }
    else{
      print "Total Value: ".$playerHandValue[0]." with ".$playerHandValue[1]." Ace.";
    }
    print "\n";
    print "\n";
  }
}
return 1;
