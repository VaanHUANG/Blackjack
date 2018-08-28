use strict;
use warnings;

package Deck;

sub new{
	#52 cards in total, suits information is ignored.
	my $class = shift @_;
	my @cards = $class->getANewDeckOf52Cards();
	return bless {'cards' => \@cards }, $class;
}

sub shuffle{
	my $class = shift @_;

	for my $counter (1..50){
		my $index1 = int(rand(52));
		my $index2 = int(rand(52));
		#swap two cards
		my $index1_card = $class->{'cards'}->[$index1];
		$class->{'cards'}->[$index1] = $class->{'cards'}->[$index2];
		$class->{'cards'}->[$index2] = $index1_card;
	}
}

#fetch and pop the first card in the array. If it is empty, it will be refilled with another deck of shuffled card.
sub fetchOneCardFromTop{
	my $class = shift @_;

	#If it is empty, use another shuffled deck of 52 cards.
	if(!(scalar @{$class->{'cards'}})){
		my @cards = $class->getANewDeckOf52Cards();
		$class->{'cards'} = \@cards;
		$class->shuffle();
	}

	return shift @{$class->{'cards'}};
}

sub getANewDeckOf52Cards{
	my @cards = ("A", "A", "A", "A");
	foreach my $i ( 2 .. 10 ){
		push @cards, "$i", "$i", "$i", "$i";
	}
	push @cards, "J", "J", "J", "J", "Q", "Q", "Q", "Q", "K", "K", "K", "K";
	return @cards;
}

return 1;
