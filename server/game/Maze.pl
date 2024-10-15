#!/usr/bin/perl
use strict;
use warnings;

# Define the game data
my %game_data = (
    'start' => {
        'description' => 'You are at the start of the maze.',
        'exits' => ['north', 'south'],
        'items' => [],
    },
    'north' => {
        'description' => 'You are at the north part of the maze.',
        'exits' => ['start', 'east'],
        'items' => ['key'],
    },
    'south' => {
        'description' => 'You are at the south part of the maze.',
        'exits' => ['start', 'west'],
        'items' => [],
    },
    'east' => {
        'description' => 'You are at the east part of the maze.',
        'exits' => ['north'],
        'items' => [],
    },
    'west' => {
        'description' => 'You are at the west part of the maze.',
        'exits' => ['south'],
        'items' => [],
    },
    'exit' => {
        'description' => 'You have reached the exit.',
        'exits' => [],
        'items' => [],
    },
);

# Initialize the player's location
my $player_location = 'start';
my @player_items = ();

# Game loop
while (1) {
    # Print the current location's description
    print $game_data{$player_location}{'description'} . "\n";

    # Print the available exits
    print "Exits: ";
    foreach my $exit (@{$game_data{$player_location}{'exits'}}) {
        print "$exit ";
    }
    print "\n";

    # Print the player's items
    print "Items: ";
    foreach my $item (@player_items) {
        print "$item ";
    }
    print "\n";

    # Get the player's input
    my $input = <STDIN>;
    chomp $input;

    # Move the player
    if ($input eq 'north' && grep { $_ eq 'north' } @{$game_data{$player_location}{'exits'}}) {
        $player_location = 'north';
    } elsif ($input eq 'south' && grep { $_ eq 'south' } @{$game_data{$player_location}{'exits'}}) {
        $player_location = 'south';
    } elsif ($input eq 'east' && grep { $_ eq 'east' } @{$game_data{$player_location}{'exits'}}) {
        $player_location = 'east';
    } elsif ($input eq 'west' && grep { $_ eq 'west' } @{$game_data{$player_location}{'exits'}}) {
        $player_location = 'west';
    } elsif ($input eq 'take key' && grep { $_ eq 'key' } @{$game_data{$player_location}{'items'}}) {
        push @player_items, 'key';
        print "You took the key.\n";
    } elsif ($input eq 'go exit' && $player_location eq 'north') {
        $player_location = 'exit';
    } else {
        print "Invalid command.\n";
    }
}
