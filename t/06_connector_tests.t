use Test::More tests => 3;
use Test::Exception;
use Test::MockObject;
use Riak::Light::Connector;

subtest "Connector should return false if can't send all bytes" => sub { 
  plan tests => 1;
  my $mock   = Test::MockObject->new;
          
  my $connector = Riak::Light::Connector->new( socket => $mock);
  
  my $message   = pack('c a*', 1, q(lol));
  
  $mock->set_false('syswrite');
  
  ok(!$connector->perform_request($message), "should return false");
};

subtest "Connector should return false if can't read all bytes" => sub { 
  plan tests => 1;
  my $mock   = Test::MockObject->new;
          
  my $connector = Riak::Light::Connector->new( socket => $mock);
  
  my $message   = pack('c a*', 1, q(lol));
  
  $mock->set_always(syswrite => bytes::length($message));
  $mock->set_false('sysread');
  
  ok(!$connector->perform_request($message), "should return false");
};

subtest "Connector should return the message in case of success" => sub { 
  plan tests => 1;
  my $mock   = Test::MockObject->new;
          
  my $connector = Riak::Light::Connector->new(host => 'host', port => 1234, socket => $mock);
  
  my $request    = pack('c a*', 1, q(lol));
  my $response   = pack('c a*', 2, q(lol));
  
  $mock->set_always(syswrite => bytes::length($request));
  
  my (@parts) = (pack('N', bytes::length($response)), $response);
  
  $mock->mock(sysread => sub {
    $_[1] = shift @parts;
    
    bytes::length($_[1]);
  });
  #$mock->set_true('send_all');  
  #$mock->set_series('read_all', pack('N',1), pack('a*', 2));
  
  is($connector->perform_request($request), $response,"should return 2");
};