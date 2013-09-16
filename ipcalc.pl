#!/usr/bin/perl -w
use strict;
use Carp qw/croak carp/;
croak "Usage: $0 ip/cidr" unless @ARGV == 1;
my $str = $ARGV[0];
my($ip,$mask) = split /\//, $str;
croak "mask must between 0 and 32" unless $mask > 0 and $mask <=32;
my @mask;
my $div = int($mask / 8); 
my $mod = $mask % 8;
for(1..$div) {
   push @mask,255;
}

push @mask, 255 & oct("0b"."1"x$mod."0"x(8-$mod))  if $mod;
push @mask, 0 while @mask != 4;
my @ip = split /\./,$ip;

my @network ;
foreach(my $i=0;$i<@ip;$i++) {
   $network[$i] = $ip[$i] & $mask[$i];
}

my $netmask = join ".",@mask;
my $network = join ".", @network;
print <<DOC;
"=================Output=================";
IP:  $ip
netmask:   $netmask
network:   $network
DOC

