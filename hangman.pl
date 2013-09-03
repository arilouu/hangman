#!/usr/bin/env perl

use warnings;
use strict;


sub main {

	my $word = &pick_a_word;
	&print_update($word, $word);
	print "\n";
	&start_game($word);

}

&main;

sub start_game {

	my $word = shift;
	my $current = $word;
	$current =~s/[\s\'\.]/-/g;		
	my $finished = 0;
	while(!$finished) {
		print "Guess a letter: ";
		my $letter = <>;
		chomp $letter;
		$letter = lc($letter);
		if($letter !~ /[a-z]/ or length($letter) > 1 ){
			#if($letter eq '' or $letter eq '.' or $letter !~ /[a-z]/ or length($letter) > 1 ){
			&print_update($word, $current);		
			next;
		} else {
	
			chomp $letter;
			
			if ($current =~s/$letter/-/gi) { #user guesses correctly, so print current word
			print "word: $word, current: $current\n";	
				&print_update($word, $current);
			}else{
				print "Try again\n";
				&print_update($word, $current);
			}


			my $answer = "-" x length($word);

			if($current eq $answer) {
				print "You Won!\n";
				$finished = 1;
			}
		}
	}
}
sub print_update {
	my($answer,$current)=@_;

	$current =~s/[\s\'\.]/-/g;		
	my @a = split(//,$answer);
	my @c = split(//,$current);

	my $count = 0;
	while($count < length($answer)) {
		if($c[$count] eq '-') {
			print "$a[$count] ";
		}else{
			print "_ ";
		}
		$count++;
	}
	print "\n";
}

sub pick_a_word {
	my $filename = "champs.txt";

	my $num_words = 1;
	my %words;

	open (my $fh, '<', $filename);
	while (my $line = <$fh>) {
		chomp $line;
		$words{$num_words} = $line;
		$num_words++;
	}

	my $dice = 1+ int rand($num_words-1);

	return $words{$dice};

}

