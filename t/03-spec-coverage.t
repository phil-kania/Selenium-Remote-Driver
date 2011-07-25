#!perl
use strict;
use warnings;

use Test::More;

unless($ENV{RELEASE_TESTING}) {
  plan(skip_all=>"Author tests not required for installation.");
}

eval {use LWP::Simple;};
skip_all("need LWP::Simple") if $@;
use Selenium::Remote::Commands;

my $uri  = "http://selenium.googlecode.com/svn/wiki/JsonWireProtocol.wiki";
my $data = get($uri);

my $todo_list = {
  'GET session/:sessionId/orientation'           => 1,
  'GET session/:sessionId/element/:id'           => 1,
  'POST session/:sessionId/modifier'             => 1,
  'POST session/:sessionId/buttonup'             => 1,
  'POST session/:sessionId/click'                => 1,
  'POST session/:sessionId/ime/deactivate'       => 1,
  'GET session/:sessionId/alert_text'            => 1,
  'POST session/:sessionId/execute_async'        => 1,
  'POST session/:sessionId/alert_text'           => 1,
  'POST session/:sessionId/buttondown'           => 1,
  'POST session/:sessionId/accept_alert'         => 1,
  'GET status'                                   => 1,
  'GET session/:sessionId/ime/activated'         => 1,
  'POST session/:sessionId/dismiss_alert'        => 1,
  'POST session/:sessionId/orientation'          => 1,
  'POST session/:sessionId/doubleclick'          => 1,
  'POST session/:sessionId/ime/activate'         => 1,
  'GET session/:sessionId/ime/active_engine'     => 1,
  'GET session/:sessionId/ime/available_engines' => 1,
};
my @lines = split(/\n/, $data);
my @methods;

for my $line (@lines) {
  if ($line =~
/\|\|\s*(GET|POST|DELETE)\s*\|\|\s*\[\S*\s+\/([^\]]*)\]\s*\|\|\s*([^\|]*?)\s*\|\|/
    ) {
    my $method = {method => $1, path => $2, desc => $3};
    push @methods, $method;
  }
}
my $commands = Selenium::Remote::Commands->new;
SOURCE_COMMAND: for my $method_source (@methods) {
  my $command = "$method_source->{method} $method_source->{path}";
  my $msg     = "find $command";
  for my $method_local (values %{$commands}) {
    if (  $method_local->{url} eq $method_source->{path}
      and $method_local->{method} eq $method_source->{method}) {
      pass($msg);
      next SOURCE_COMMAND;
    }
  }
TODO: {
    local $TODO = "need to create command" if $todo_list->{$command};
    fail($msg);
  }
}

LOCAL_COMMAND: for my $method_local (values %{$commands}) {
  my $msg = "extra command $method_local->{method} $method_local->{url}";
  for my $method_source (@methods) {
    if (  $method_local->{url} eq $method_source->{path}
      and $method_local->{method} eq $method_source->{method}) {
      next LOCAL_COMMAND;
    }
  }
TODO: {
    local $TODO = "Investigate extra methods";
    fail($msg);
  }
}

done_testing;
