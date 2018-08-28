#!/usr/bin/perl

use strict;
use warnings;
use Term::ANSIColor qw(:constants);
$Term::ANSIColor::AUTORESET = 1;
use Scalar::Util qw(looks_like_number);

require Dealer;
require AIPlayer;
require HumanPlayer;

srand(10);
my @players;

#for user to configure the game: how many players and whether they are AI players or computer players, and name of them.
print BLUE BOLD "WELLCOME, BLACKJACK PLAYER!\n";
print BLACK "Please input some infor to initialize the game.\n";
print BLACK "*****Number of players:*****\n";
my $numPlayer = <STDIN>;
chomp $numPlayer;
while(not looks_like_number($numPlayer)){
	$numPlayer = <STDIN>;
	chomp $numPlayer;
}
foreach my $x (1 .. $numPlayer){
	print "Player $x:\n";

	print BRIGHT_BLACK "Player type: 'h' human player, 'a' AIPlayer\n";
	my $class = <STDIN>;
	chomp $class;
	while($class ne 'h' && $class ne 'a'){
		print BRIGHT_RED "Invalid input, please input again!\n";
		print BRIGHT_BLACK "Type of player: 'h' human player, 'a' AIPlayer\n";
		$class = <STDIN>;
		chomp $class;
	}

	print BRIGHT_BLACK "Name of player : ";
	my $name = <STDIN>;
	chomp $name;

	if($class eq 'h'){
		push @players, HumanPlayer->new($name);
	}else{
		push @players, AIPlayer->new($name);
	}
}


print BLACK "*****Only one dealer*****\n";
print BRIGHT_BLACK "Name of dealer : ";
my $dealerName = <STDIN>;
chomp $dealerName;

print GREEN "Configuration complete!\n";
#end of the configuration

print BLUE "\n*****Game start*****\n";
my $dealer = Dealer->new($dealerName, \@players);

#let all players know who is the dealer
foreach my $player (@{$dealer->{'players'}}){
	$player->setDealer($dealer);
}


print BRIGHT_BLACK "'s' to start, 'q' to quit\n";
my $input = <STDIN>;
chomp $input;
while($input ne 's' && $input ne 'q'){
	print BRIGHT_RED "Invalid input, please input again!\n";
	print BRIGHT_BLACK "'s' to start, 'q' to quit\n";
	$input = <STDIN>;
	chomp $input;
}

while($input eq 's'){
	$dealer->start();
	$dealer->reset();

	print BRIGHT_BLACK "'s' to start, 'q' to quit\n";
	$input = <STDIN>;
	chomp $input;
	while($input ne 's' && $input ne 'q'){
		print BRIGHT_RED "Invalid input, please input again!\n";
		print BRIGHT_BLACK "'s' to start, 'q' to quit\n";
		$input = <STDIN>;
		chomp $input;
	}
}
